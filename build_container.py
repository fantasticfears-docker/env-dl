"""Builds a container."""

import sys
import os.path
from subprocess import call

def read_metadata(filename):
    META_FIELDS = ['name', 'version']

    with open(filename) as f:
        metadata = {}
        for line in f:
            if not line.startswith('#'):
                break
            attribute, *description = line[1:].rstrip().split(':')
            description = ":".join(description).strip()
            attribute = attribute.strip().lower()

            if attribute in META_FIELDS:
                metadata[attribute] = description
        if 'version' in metadata:
            metadata['minor_version'] = ".".join(metadata['version'].split('.')[:2])

        return metadata

def gen_tag(tag, version):
    return tag + ":" + version

def build_container(dir):
    filename = os.path.join(dir, "Dockerfile")
    metadata = read_metadata(filename)
    print(metadata)
    tag_name = gen_tag(metadata['name'], metadata['version'])
    call(["docker", "build", "-t", tag_name, "-f", filename, dir])

    minor_tag = gen_tag(metadata['name'], metadata['minor_version'])
    call(["docker", "tag", tag_name, minor_tag])

    latest_tag = gen_tag(metadata['name'], 'latest')
    call(["docker", "tag", tag_name, latest_tag])

if __name__ == '__main__':
    build_container(sys.argv[1])
