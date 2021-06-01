# Anvy Digital Developed Environment
Environment of all projects for Anvy Digital

## How to build
```
$ git clone git@github.com:anvydigital/anvydevenv.git
$ cd anvydevenv
```

Go to version of server want to build
```
$ docker build -t=anvydigital/anvydevenv:latest -f Ubuntu/20.04/Dockerfile .
```
## Don't want to build, ok just pull from hub
```
docker pull anvydigital/anvydevenv
```

## How to run container
### On Window
```
$ docker images
$ docker run -it --privileged -p "80:80" -p "25:25" -p "27017:27017" -p "27018:27018" -p "443:443" -v C:\www:/var/www:consistent -v C:\www\database:/root/database/:consistent --name AnvyDevServer <imageID>
```

### On Linux or MacOS
```
$ docker images
$ docker run \
-it \
--privileged \
-p "80:80" \
-p "25:25" \
-p "27017:27017" \
-p "443:443" \
-v /var/www:/var/www:consistent \
-v /var/www/database:/root/database/:consistent \
--name AnvyDevServer \
<imageID>
```

### Initial start
Apply my alias commands
```
$ source ~/.bash_profile
```

### Add new site:
```
$ addsite
or
$ ./var/www/create-site.sh
```

### Config SSL:
```
$ configssl
or
$ ./var/www/config-ssl.sh
```
