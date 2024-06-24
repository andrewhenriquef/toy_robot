# Toy Robot Simulator

You can read more about the challenge through the link below:

[coding challenge link](https://github.com/pin-people/toy_robot)

# How to run this code

## Setup project

### Prerequisites

- Install ruby 3.3.3, sqlite3 and redis


### Install Project Libraries

Run the following command to install the necessary libraries:

```
bundle install
```

### Setup Project Database

Create and set up the database by running:



```
rails db:create db:migrate db:seed
```

### Run Project Test Suite

Execute the project's test suite with:


```
rspec spec/
```

### Run Web Application

Start the Rails server:

```
rails server
```

Access the http://localhost:3000 on your browser

### Run CLI Application

To start the CLI:

```
bin/cli
```

To read commands from a file in CLI mode:

```
bin/cli -f spec/fixtures/sample_a
```

## Considerations
### Current Integrations

- This application integrates a web app with the CLI. It uses Turbo from Hotwire to synchronize commands directly between the CLI and the web app in both directions.

### Known Issues

- In the web version, the robot starts in a "placed" state. This behavior is an issue that needs to be addressed. Limited progress was made this week due to personal commitments.

### Future Improvements
- Resolve the placement issue in the web version.
- Refactor the code to unify the "place" command across the app.
- Enable synchronous updates of the robot's position in both the web and CLI versions to enhance interaction.
- Develop a Docker file to facilitate rapid project setup.
- Introduce multiple "tabletops" and robots to allow gameplay on the same or different surfaces.
- Create a friendly interface