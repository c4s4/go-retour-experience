#!/usr/bin/env python
# encoding: UTF-8

import sys

FOOTNOTE = '.footnote[%s]'
TITLE = '''
template: inverse
%s
'''
PAGE = '''
layout: false
.left-column[
%s
]
.right-column[
%s
]
'''
root = ''
previous = []


def process(page):
    global root, previous
    lines = page.split('\n')
    if lines[-1].startswith('\\'):
        lines[-1] = FOOTNOTE % lines[-1][1:]
    if lines[0].startswith('/'):
        items = lines[0].split('/')[1:]
        if items[0] != root:
            root = items[0]
            previous = []
        if len(items) > 1:
            previous.append(items[1])
        path = "### %s" % root
        for prev in previous[-6:]:
            path += '\n#### - %s' % prev
        return PAGE % (path, '\n'.join(lines[1:]))
    else:
        return TITLE % '\n'.join(lines)


def main(markdown, template):
    with open(markdown) as stream:
        text = stream.read().strip()
    pages = [p.strip() for p in text.split('---')]
    processed = [process(p) for p in pages]
    with open(template) as stream:
        source = stream.read()
    html = source.replace('<? CONTENT ?>', '\n---\n'.join(processed))
    print(html)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Must pass markdown and template files on command line")
    main(markdown=sys.argv[1], template=sys.argv[2])
