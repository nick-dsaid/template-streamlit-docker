# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.10

# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME

## For pip
# COPY requirements.txt ./
# RUN pip install -r requirements.txt

## For pipenv
#COPY Pipfile.lock ./
#COPY Pipfile ./
#RUN pip install pipenv
#RUN pipenv install --system --deploy --ignore-pipfile

## For poetry
 COPY pyproject.toml poetry.lock ./
 RUN pip install poetry
 RUN poetry config virtualenvs.create false
 RUN poetry install --no-interaction --no-ansi


# Copy local code to the container image.
COPY . ./

# Run the web service on container startup.
EXPOSE 80
CMD streamlit run --server.port 80 Chat2SQL.py