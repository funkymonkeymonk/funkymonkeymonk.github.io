---
layout: post
section-type: post
title: Keeping the Pipeline in Source Control using Make
category: tech
tags: [ 'CI', 'CD']
---

### This post is a work in progress.

As someone who subscribes to the belief that the right tool for the job is the
tool that the team is most comfortable working in, I have found the need to be
extremely flexible in how I work. I often change languages and tool sets
frequently.  In the most extreme cases every few hours as I move from one pair
to the next. I love knowing that each developer I pair with is working with the
tools that make them the most functional, but it comes at the cost of massive
amounts of context switching for me.


I feel the need to create an interface layer.  Something that allowed me to talk
about the build pipeline in abstract concepts that mapped to simple commands on
the terminal. I want to keep all thee steps for my pipeline in my source
control. I wanted to keep this interface layer completely logic free, and rely
on the build tools that are specific to the language for the heavy lifting.
Lastly I wanted two developers using two completely different stacks to be able
to talk about their build chains in a way that didn't require both to have a
deep understand the others tooling.


For a while I used bash scripts to do this. They are very available and in may
ways create a runnable documentation of the build pipeline in the code base. I
learned in doing this I ended up creating functions that called other functions,
and that for a one line command to run a build I was creating another 5 lines of
scaffolding. So I began my search for a tool as ubiquitous as bash, but that
provided the scaffolding to do solid argument handling and chaining of different
steps. I decided my next project would use make as that interface.


This is a snippet of my Makefile template.

```
project_name := "projectname"
project_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

list:
  @sh -c "$(MAKE) -p no_targets__ | \
    awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /); \
    for(i in A) \
    print A[i]}' | \
    grep -v '__\$$' | \
    grep -v 'make\[1\]' | \
    grep -v 'Makefile' | \
    sort"

no_targets__:

docs:
  @cat README.md

build:
  @echo No build step defined yet for $(project_name)

# test your application
test: coverage

unit:
  @echo No unit step defined yet for $(project_name)

# show coverage in html format
coverage: unit
  @echo No coverage step defined yet for $(project_name)

publish:
  @echo No publish step defined yet for $(project_name)

promote:
  @echo No promotion step defined yet for $(project_name)

deploy:
  @echo No coverage step defined yet for $(project_name)
</pre>
```
I work with a developer to fill this template out with the proper commands to
run different parts of the pipeline. Now, despite working with many different
languages and toolsets, the language of continuous integration and delivery
practices can be the same.
