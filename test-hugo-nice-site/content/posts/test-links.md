---
title: "Test good links"
date: 2023-01-03T15:26:58-08:00
tags: ["test"]
categories: ["Tools"]
---

## Introduction

Test some links inline and in single lines

### Inline links

This is some good content. 

This is a link to [my web site](https://www.mkamarin.com/) and this is a ![image file](/image01.png).

The following are several shortcuts: an email <fake@mail.com> another email <mailto:fake@mail.com> This is a URL: <http://www.example.com>

This is a HTML tag <a href="http://www.examp[le.com">my example</a>

The following are [Hugo shortcodes](https://gohugo.io/content-management/shortcodes/).  Not all the shortcuts are supported. The supported subset is as follows:

Tweet {{< tweet user="SanDiegoZoo" id="1453110110599868418" >}}  Youtube {{< youtube w7Ft2ymGmfc >}}  


### Single line links

This is a link to 

[my web site](https://www.mkamarin.com/)

This is an image:

![image file](/image01.png)


This is an email:

<fake@mail.com>

<mailto:fake@mail.com>

This is a URL:

<http://www.example.com>

This is a HTML tag `<a href="uri">label</a>`:

<a href="http://www.examp[le.com">my example</a>

The following are [Hugo shortcodes](https://gohugo.io/content-management/shortcodes/).  
Not all the shortcuts are supported. The supported subset is as follows:


**tweet**

 {{< tweet user="SanDiegoZoo" id="1453110110599868418" >}}  

 {{% tweet user="SanDiegoZoo" id="1453110110599868418" %}}  

becomes `https://twitter.com/SanDiegoZoo/status/1453110110599868418`

**Youtube**

 {{< youtube w7Ft2ymGmfc >}}  

 {{% youtube w7Ft2ymGmfc %}}  

Becomes `https://www.youtube.com/watch?v=w7Ft2ymGmfc`


That is all.

