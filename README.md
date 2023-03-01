**Note, March 2023: The Rxivist project has been discontinued.** This code will remain available indefinitely, but we can't make any assurances about its functionality going forward as dependencies and external data sources change.

.

.

.

.

# rxivist

This repository holds code for the website currently deployed at rxivist.org; it's one half of the Rxivist platform, which also includes an API in [a separate repository](https://github.com/blekhmanlab/rxivist).

This web application doesn't connect to any database; it only gets data by calling the Rxivist API, which must be running and accessible. (Specify its hostname in `config.py`, which must be updated for your deployment.)

## Deploying

```sh
git clone https://github.com/blekhmanlab/rxivist_web.git
cd rxivist_web
docker build . -t rxivist_web:latest
# (The name of the image doesn't matter, but "rxivist_web" seems intuitive.)
docker run -d --rm --name rxweb -p 80:80 rxivist_web:latest
```

## Development

As mentioned above, you will need a functioning Rxivist API for this web application to work. See [the API's repo](https://github.com/blekhmanlab/rxivist) for instructions about how to get the API container running, then follow these commands to start up the web app. It mounts your local copy of the codebase into the container, so you should be able to edit the code on your workstation and see the changes immediately. (Assumptions below: Your API is running in a container called `rxapi` and yuou want to access the website via `localhost:8123`.)

```sh
git clone https://github.com/blekhmanlab/rxivist_web.git
cd rxivist_web
docker run -it --rm --name rxweb -p 8123:80 -v "$(pwd)":/app --link rxapi python:slim bash
cd app
pip3 install -r requirements.txt
python3 main.py
```
