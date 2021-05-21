## ft_server

![Build Status](https://img.shields.io/github/license/selysse/ft_server?style=plastic)
![Build Status](https://img.shields.io/github/languages/code-size/selysse/ft_server?style=plastic)
![Build Status](https://img.shields.io/github/last-commit/selysse/ft_server?style=plastic)

My repositories for the 21 (42) schools "server" project

![GitHub Logo](/png/result.png)

Project where we containerise a nginx webserver together with a mysql database server. Under nginx both wordpress and PhpMyAdmin are installed.

## Installation
```
git clone https://github.com/selysse/ft_server.git
```
## Build image
```
$ docker build -t ft_server .
```
##  Run container
```
$ docker run -it -p80:80 -p443:443 ft_server
```
