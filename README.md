# Finance Dashboard built using RShiny

The `CSV` included contains the data we are using for the project.

The `global.R` file is where the core logic of the data processing is held.

`app.R` calls on `global.R` for data and provides UI elements and other visualization specific code.

## How to Run

Open both `app.R` and `global.R` in **RStudio** and install all packages and dependencies.

Navigate back to `app.R` and hit 'run app' in the top right corner

![run app](https://i.imgur.com/09QIwX3.png)

It will load up this screen where you click on the data file you have. This csv has the cleaned and collated index values for each of the major global indices across a specified period of time.

![load data](https://i.imgur.com/3D000C2.png)

## Goals and Updates
The focus of this project was to come up with a way to visualize the correlation of various global indices, observe periods of drawdown, attempt to model what a custom portfolio of these indices might have historically returned as well as find a way to come up with a portfolio matching our target volatility

This project was completed in 2021 with my friend and colleague as part of our internship and was built off pre-existing projects by multiple users such as pmaji (https://github.com/pmaji/financial-asset-comparison-tool).

The codebase is not actively maintained and is only put up here for educational purposes. If there are any breaking updates to R/RStudio or the above libraries, you can reach out to me via email to notify me and I'll try to update the code.
