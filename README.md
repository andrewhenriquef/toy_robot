# Toy Robot Simulator

You can read more about the challenge through the link below:

[coding challenge link](https://github.com/pin-people/toy_robot)

# How to run this code

## Setup project

### Prerequisites

- docker

### Install Project Libraries

Run the following command to install the necessary libraries:

```
docker compose build --no-cache
```

### Setup Project Database

Create and set up the database by running:

```
docker compose run -it app bundle exec rails db:prepare
```

### Run Project Test Suite

Execute the project's test suite with:


```
docker compose run app bundle exec rspec
```

### Run Web Application

Start the Rails server:

```
docker compose up app
```

Access the http://localhost:3000 on your browser

### Run CLI Application

To start the CLI:

```
docker compose run -it app bin/cli
```

To read commands from a file in CLI mode:

```
docker compose run -it app bin/cli -f spec/fixtures/sample_c
```

## Considerations
### Current Integrations

- This application integrates a web app with the CLI. It uses Turbo from Hotwire to synchronize commands directly between the CLI and the web app in both directions.

### Future Improvements
- Introduce multiple "tabletops" and robots to allow gameplay on the same or different surfaces.
- Create a friendly interface