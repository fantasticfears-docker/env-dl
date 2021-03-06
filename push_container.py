
import sys
import os.path
from subprocess import call
from build_container import gen_tag, read_metadata, pretty_call

def push_container(dir):
    filename = os.path.join(dir, "Dockerfile")
    metadata = read_metadata(filename)

    tag_name = gen_tag(metadata['name'], metadata['version'])
    cmd = ["docker", "push", tag_name]
    pretty_call(cmd)

    minor_tag = gen_tag(metadata['name'], metadata['minor_version'])
    cmd = ["docker", "push", minor_tag]
    pretty_call(cmd)

    latest_tag = gen_tag(metadata['name'], 'latest')
    cmd = ["docker", "push", latest_tag]
    pretty_call(cmd)

if __name__ == '__main__':
    push_container(sys.argv[1])
