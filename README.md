# Magento-AWS-Linux-2-Instalation
this open Source project simplifies the creation, maintenance, validation, sharing, and deployment of the Magento 2 and LEMP stack instalation.
LEMP (Linux, NGINX, MySQL (MariaDb), PHP) is a very common example of a web service stack, named as an acronym of the names of its original four open-source components: the Linux operating system, the Apache HTTP Server, the MySQL relational database management system (RDBMS), and the PHP programming language. The LEMP components are largely interchangeable and not limited to the original selection. As a solution stack, LEMP is suitable for building dynamic web sites and web applications.

Since its creation, the LEMP model has been adapted to other componentry, though typically consisting of free and open-source software. 

 "LEMP" now refers to a generic software stack model. The modularity of a LEMP stack may vary, but this particular software combination has become popular because it is sufficient to host a wide variety of website frameworks, such as Joomla, WordPress and Drupal. The components of the LAMP stack are present in the software repositories of most Linux distributions.
Curtan reposetory wors for EC2 AWS LINUX2 / Centos 7 / RedHat 7

The LAMP bundle can be combined with many other free and open-source software packages, MAgento uses REdis 6.0 and Elastic Search aditionaly.

# Why not Magento Docker ?

There are also times when Docker isn’t the best solution:

1. Your MAgento app is complicated and you are not/do not have a sysadmin. For large or complicated MAgento applications, using a pre-made Dockerfile or pulling an existing image will not be sufficient. Building, editing, and managing communication between multiple containers on multiple servers is a time-consuming task.

2. Performance is critical to eCommerce application. Docker shines compared to virtual machines when it comes to performance because containers share the host kernel and do not emulate a full operating system. However, Docker does impose performance costs. Processes running within a container will not be quite as fast as those run on the native OS. If you need to get the best possible performance of Magento  out of your server, you may want to avoid Docker.

3. You don’t want upgrade hassles. Docker is a new technology that is still under development. To get new features you will likely have to update versions frequently, and backward compatibility with previous versions is not guaranteed.

4. Docker’s containerization approach raises its own security challenges, especially for more complicated applications. These issues are solvable, but require attention from an experienced security engineer. (See the More Info section for links to discussions of these issues).

5. Clusters. This repo is for higload MAgento cluster and you will use native cloud services instead of docer comtainers 

You can also use this script/recipy to build Docker usin amazonlinux:latest as a base image.


# Structire of the project:

## Components

The whale instalation process is separeted into Components

A component script defines the sequence of steps required install the instance with application. Components are executed on the instance via ssh or durin EC2 creation using User Data. 
start recipe has all component in the right order.

## Image recipe

An image recipe is a main documant that defines the source image and the components to be applied to the instance to produce the desired configuration .

