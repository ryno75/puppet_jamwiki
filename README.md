#### Table of Contents

2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with jamwiki](#setup)
    * [What jamwiki affects](#what-jamwiki-affects)
    * [Getting started with jamwiki](#getting-started-with-jamwiki)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Module Description

This module manages jamwiki and relies upon hiera to supply parameters

## Setup

include jamwiki

### What jamwiki affects

* Everything managed by Puppet on a particular system

### Getting started with jamwiki

Basic steps needed to get the module up and running. 

If your most recent release breaks compatibility or requires particular steps for upgrading, you may wish to include an additional section here: Upgrading (For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here. 

E.g.
~~~
include jamwiki

class { jamwiki: }
~~~

## Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 
