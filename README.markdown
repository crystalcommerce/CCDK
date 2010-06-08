# CCDK

The Crystal Commerce Development Kit

## Description

CCDK is a set of extensions made to ease development of Rails
applications. Many of the extensions monkey-patch core classes and
should be used for debugging etc, not included in a running production
application.

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
