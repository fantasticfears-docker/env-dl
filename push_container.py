
import sys
import os.path
from subprocess import call
from build_container import gen_tag, read_metadata, print_command

def push_container(dir):
    filename = os.path.join(dir, "Dockerfile")
    metadata = read_metadata(filename)

    tag_name = gen_tag(metadata['name'], metadata['version'])
    minor_tag = gen_tag(metadata['name'], metadata['minor_version'])
    cmd = ["docker", "tag", tag_name, minor_tag]
    print_command(cmd)
    call(cmd)

    latest_tag = gen_tag(metadata['name'], 'latest')
    cmd = ["docker", "tag", tag_name, latest_tag]
    call(cmd)

if __name__ == '__main__':
    push_container(sys.argv[1])
