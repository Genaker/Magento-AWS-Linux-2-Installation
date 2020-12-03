# Magento Commerce Cloud to AWS Linux 2 (Centos 7) / Azure Centos 8.2 Installation migration tool with ARM Graviton2 instances support  
Every merchant wants to have a faster website and pay less for hosting. Magento Commerce Cloud works only for small projects without traffic. If you are having 2+ requests per second you will safer with Magento cloud, because it was designed not for Magento. It is the Platform.SH hosting for Drupal. And really it is not a real cloud it just uses Amazon Web Services to buy instances. The best way to improve performance and price it is to buy services directly from AWS without any gasket. Also, Magento Cloud also supports only Commerce/Enterprise clients, not the Open Source free version. 
This Open Source project simplifies the creation, maintenance, validation, sharing, and deployment of the Magento 2 and LEMP stack installation.
LEMP (Linux, NGINX, MySQL (MariaDB), PHP) is a very common example of a web service stack, named as an acronym of the names of its original four open-source components: the Linux operating system, the NGINX HTTP Server, the MySQL relational database management system (RDBMS), and the PHP programming language. The LEMP components are largely interchangeable and not limited to the original selection. As a solution stack, LEMP is suitable for building dynamic web sites and web applications.

Since its creation, the LEMP model has been adapted to other componentry, though typically consisting of free and open-source software. 

 "LEMP" now refers to a generic software stack model. The modularity of a LEMP stack may vary, but this particular software combination has become popular because it is sufficient to host a wide variety of website frameworks, such as Magento 2, Shopware 6, Sylius,  WordPress, and Drupal. The components of the LAMP stack are present in the software repositories of most Linux distributions.
Curtain repository wors for EC2 AWS LINUX2 / Centos 7 / RedHat 7

The LAMP bundle can be combined with many other free and open-source software packages, Magento uses Redis 6.0 and Elastic Search additionally.

# Why not Magento Docker Compose?

There are also times when Docker isn’t the best solution:

1. Your Magento app is complicated and you are not/do not have a sysadmin. For large or complicated Magento applications, using a pre-made Dockerfile or pulling an existing image will not be sufficient. The building, editing, and managing communication between multiple containers on multiple servers is a time-consuming task.

2. Performance is critical to eCommerce applications. Docker shines compared to virtual machines when it comes to performance because containers share the host kernel and do not emulate a full operating system. However, Docker does impose performance costs. Processes running within a container will not be quite as fast as those run on the native OS. If you need to get the best possible performance of Magento out of your server, you may want to avoid Docker.

3. You don’t want to upgrade hassles. Docker is a new technology that is still under development. To get new features you will likely have to update versions frequently, and backward compatibility with previous versions is not guaranteed.

4. Docker’s containerization approach raises its own security challenges, especially for more complicated applications. These issues are solvable, but require attention from an experienced security engineer. (See the More Info section for links to discussions of these issues).

5. Clusters. This repo is for high load Magento cluster and you will use native cloud services instead of docker containers 

You can also use this script/recipe to build Docker using amazonlinux:latest as a base image.


# Structure of the project:

## Components

The whale installation process is separated into Components

A component script defines the sequence of steps required to install the instance with the application. Components are executed on the instance via ssh or during EC2 creation using User Data. 
start recipe has all components in the right order.

## Image recipe

An image recipe is the main document that defines the source image and the components to be applied to the instance to produce the desired configuration.

# How to RUN: 

## Run the main Recipe
```
sudo bash install-all.sh
```
You probably need some customization. Also, you can create your own configuration. For example, You wanna use AWS services MYSQL RDS, ElastiCahe Redis, Elastic Search you can remove those components. If you have any issues create the ticket and I help you. 

# Support and Questions 

Send email to: yegorshytikov@gmail.com or create ticke/issue. 


