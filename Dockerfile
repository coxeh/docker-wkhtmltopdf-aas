FROM openlabs/docker-wkhtmltopdf:latest
MAINTAINER Carl Glaysher <carl@ecce.uk>

# Install dependencies for running web service
RUN apt-get update
RUN apt-get install -y python-pip
RUN pip install werkzeug executor 'gunicorn==19.3.0'
RUN apt-get clean autoclean && apt-get autoremove --yes

ADD app.py /app.py
EXPOSE 80

ENTRYPOINT ["usr/local/bin/gunicorn"]

# Show the extended help
CMD ["-b", "0.0.0.0:80", "--log-file", "-", "app:application"]
