# CCDK

The Crystal Commerce Debugging Kit

## Description

CCDK is a set of tools made to ease development of Rails applications
developed at [Crystal Commerce](http://www.crystalcommerce.com). It
includes both executable scripts and modules that can be mixed into
classes to help debug. The code herein is not designed to be run as
part of a production application, just for use while building one.

## Included Executables

* `cc_track_user`

## `cc_track_user`

`cc_track_user` is a script that will search a Rails log file for a
specific IP address and display the actions that the user has
performed. This can be helpful in tracking the steps a user took to
get their session into a particular state.

### Usage

`cc_track_user IP_ADDR FILE [FILE ...]`

* IP_ADDR is the ip address to track
* FILE is a a file (or list of files) to search across

If any the file names passed to `cc_track_user` end in `.gz`,
`cc_track_user` will assume that they have been gzipped when it opens
them. This makes it easy to follow a user's actions across several
days of logs without having to unzip the file first.

It is suggested to pass the files to `cc_track_user` from oldest to
newest so the output is chronological.

## Included Modules

* `Ccdk::TDump`

## `Ccdk::TDump`

`TDump` is a module that allows you to display a templated
representation of a record using the `#tdump` method. It can be passed
a filename, a string template, an erb object, or an IO (really
anything that responds to `#read`).

### Examples

    car.tdump('I have a <%= year %> <%= make %> <%= model %>')

    product.tdump('path/to/product_template.erb')
