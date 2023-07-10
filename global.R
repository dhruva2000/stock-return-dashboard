####################################
# Authors: Colleague 1             #
#          Dhruva Reddy            #
####################################

# Load packages
library(tidyverse)
library(ggcorrplot)
library(zoo)
library(xts)
library(testit)
library(PerformanceAnalytics)

#choose source file to work with
file_name = file.choose()
source_file = read_csv(file_name)
source_file$Date = as.Date(source_file$Date, format = "%Y-%m-%d")

#########################
rollingcorr = function(corrrange, duration, corrvar1, corrvar2)
{

  #filter source file by date range specified
  source_file_filtered <- source_file %>% 
    filter(Date >= corrrange[1] & Date <= corrrange[2])
  
  #read source file as zoo dataset
  index_data_zoo <- read.zoo(source_file_filtered)
  index_data_zoo <- apply.weekly(index_data_zoo, colMeans)
  
  #calculate rolling correlation of zoo dataset
  rollcorr_index_data_zoo = rollapply(
    index_data_zoo,
    width=duration,
    align="left",
    function(x) cor(x[,corrvar1],x[,corrvar2]),
    by.column=FALSE)
  
  #convert zoo file back to dataframe
  rollcorr_index_data_df = fortify.zoo(rollcorr_index_data_zoo, name="Date")
  colnames(rollcorr_index_data_df)[2] <- "Data"
  rollcorr_index_data_df$posneg[rollcorr_index_data_df$Data >= 0] <- "neg"
  rollcorr_index_data_df$posneg[rollcorr_index_data_df$Data <= 0] <- "pos"
  rollcorr_index_data_df$min <- ifelse(rollcorr_index_data_df$Data >= 0, 0, rollcorr_index_data_df$Data)
  rollcorr_index_data_df$max <- ifelse(rollcorr_index_data_df$Data >= 0, rollcorr_index_data_df$Data, 0)
  
  #plot dataframe of re-converted dataset containing rolling correlations
  g = ggplot(data = rollcorr_index_data_df, aes(x = Date, y = Data)) +
    scale_fill_manual(values = c("green", "red")) +
    geom_col(aes(col = posneg, fill = posneg)) + scale_colour_manual(values = c("green", "red")) + theme_bw() +
    geom_hline(yintercept = 0, linetype = "dashed", colour = "blue") + geom_hline(yintercept = 0.5, linetype = "dashed", colour = "blue") +
    geom_hline(yintercept = -0.5, linetype = "dashed", colour = "blue") +
    xlab("Time") + ylab("Correlation") + ylim(-1,1) +
    ggtitle(paste0(duration, " week rolling correlation of ", corrvar1, " & ", corrvar2, " from ", corrrange[1], " to ", corrrange[2])) +
    theme(plot.title = element_text(hjust=0.5))
  g<- g + theme(legend.position = "none")
  print(g)
}

#########################
corrheatmap = function(corrrange)
{
  #filter source file by date range specified
  source_file_filtered <- source_file %>% 
    filter(Date >= corrrange[1] & Date <= corrrange[2])
  heatcorr <- cor(x=source_file_filtered[2:(length(source_file_filtered-1))], method = "pearson", use = "pairwise.complete.obs")
  g = ggcorrplot(heatcorr, method = "square", outline.col = "white", type = "full", lab = TRUE, tl.srt = 90, legend.title = "Correlation", 
                 title = "Correlation Heatmap of Indexes", theme(plot.title = element_text(hjust = 0.5)))
  print(g)
}

#########################
returncolumn = function(cumvar, cumrange)
{
  #filter source file by date range specified
  source_file_filtered <- source_file %>% 
    filter(Date >= cumrange[1] & Date <= cumrange[2])
  a <- source_file_filtered[[cumvar]]
  
  #create new column called Cumulative_Returns to convert % daily returns
  source_file_filtered$Cumulative_Returns <- cumsum(a)
  g = ggplot(data = source_file_filtered, mapping = aes(x=Date, y=Cumulative_Returns)) + 
    geom_line(color="blue") + ggtitle(paste("Weekly Cumulative Returns for", cumvar, "from", cumrange[1], "to", cumrange[2])) +
    geom_hline(yintercept = 0, linetype = "dashed") + theme(plot.title = element_text(hjust=0.5)) +
    ylab("Cumulative Returns (%)")
  print(g)  
}

#########################
cumstats = function(cumrange, cumvar)
{
  #filter source file by date range specified
  source_file_filtered <- source_file %>% 
    filter(Date >= cumrange[1] & Date <= cumrange[2])
  a <- source_file_filtered[[cumvar]]
  
  #create new column called Cumulative_Returns to convert % daily returns
  Cumulative_Returns <- cumsum(a)
  
  #Create new data matrix called cumulative_var_returns 
  cumulative_var_returns = data.matrix(Cumulative_Returns)

  total_return = cumulative_var_returns[[nrow(cumulative_var_returns),1]]
  annualized_vol = sd(source_file_filtered[[cumvar]])*(52^0.5)
  g = paste("For", cumvar,"between", cumrange[1],"and",cumrange[2],":",
            "Total return: ",round(total_return,1),"%,",
            "Annualized vol: ",round(annualized_vol,1),"%")
  print(g)
}

#########################
dist_returns = function(distrange, distvar)
{
  #filter source file by date range specified
  source_file_filtered <- source_file %>% 
    filter(Date >= distrange[1] & Date <= distrange[2])
  
  g = ggplot(data = source_file_filtered, aes(x = source_file_filtered[[distvar]])) +
    geom_histogram(binwidth = 0.1, color = "green3", fill = "green4") +
    labs(title = paste("Return Distribution for", distvar, "from", distrange[1], "to", distrange[2]), x = "Weekly Returns (%)", y = "Frequency") +
    theme(plot.title = element_text(hjust=0.5)) + geom_vline(xintercept = 0)
  print(g)
}

#########################
drawdownmap = function(drawrange, drawvar1, drawvar2)
{
  
  source_file_filtered <- source_file %>%
    filter(Date >= drawrange[1] & Date <= drawrange[2])
  
  source_file_zoo <- read.zoo(source_file_filtered)/100
  
  g <- chart.Drawdown(source_file_zoo[,c(drawvar1,drawvar2)],
                      plot.engine = "ggplot2")
  
  g <- g + ggtitle(paste0("Drawdowns of ", drawvar1, " and ", drawvar2," between ", drawrange[1], " & ", drawrange[2])) +
    theme(plot.title = element_text(hjust=0.5)) + labs(x = "Drawdown (%)", y = "Date") + scale_y_continuous(labels = scales::percent)
  print(g)
}

#########################
calculate_portfolio_returns = function(customrange, asset_weights)
{
  #filter source file by date range specified
  source_file_filtered <- source_file %>% 
    filter(Date >= customrange[1] & Date <= customrange[2])
  
  source_file_filtered_no_date <- source_file_filtered[,2:length(source_file_filtered)]
  
  #create new column called Cumulative_Returns to convert % daily returns
  Cumulative_Returns <- cumsum(source_file_filtered_no_date)
  
  # Extract necessary parameters
  n_cols = ncol(Cumulative_Returns)
  n_assets = n_cols
  
  #To ensure portfolio is always weighted at 100% at all times
  assert(length(asset_weights) == n_assets)
  assert(abs(sum(asset_weights)-1) <= 0.001)
  
  portfolio_returns = data.matrix(Cumulative_Returns) %*% asset_weights
  portfolio_returns_with_date = cbind(source_file_filtered[,1], portfolio_returns)
  g = ggplot(data = portfolio_returns_with_date, mapping = aes(x=Date, y=portfolio_returns)) +
   geom_line(color="blue") + ggtitle(paste("Custom Portfolio Returns from", customrange[1], "to", customrange[2])) +
   geom_hline(yintercept = 0, linetype = "dashed") + theme(plot.title = element_text(hjust=0.5)) +
    ylab("Portfolio Returns (%)")
  print(g)
}

#########################
customhist = function(customrange, asset_weights)
{
  #filter source file by date range specified
  source_file_filtered <- source_file %>% 
    filter(Date >= customrange[1] & Date <= customrange[2])
  
  source_file_filtered_no_date <- source_file_filtered[,2:length(source_file_filtered)]
  
  # Extract necessary parameters
  n_cols = ncol(source_file_filtered_no_date)
  n_assets = n_cols
  
  #To ensure portfolio is always weighted at 100% at all times
  assert(length(asset_weights) == n_assets)
  assert(abs(sum(asset_weights)-1) <= 0.001)
  
  portfolio_returns = data.matrix(source_file_filtered_no_date) %*% asset_weights
  portfolio_returns_with_date = cbind(source_file_filtered[,1], portfolio_returns)
  g = ggplot(data = portfolio_returns_with_date, mapping = aes(x = portfolio_returns)) +
    geom_histogram(binwidth = 0.1, color = "green3", fill = "green4") +
    labs(title = paste("Return Distribution for Custom Portfolio from", customrange[1], "to", customrange[2]), x = "Weekly Returns (%)", y = "Frequency") +
    theme(plot.title = element_text(hjust=0.5)) + geom_vline(xintercept = 0)
  print(g)
}

#########################
customstats = function(customrange, asset_weights)
{
  #filter source file by date range specified
  source_file_filtered <- source_file %>% 
    filter(Date >= customrange[1] & Date <= customrange[2])
  
  source_file_filtered_no_date <- source_file_filtered[,2:length(source_file_filtered)]
  
  #create new column called Cumulative_Returns to convert % daily returns
  Cumulative_Returns <- cumsum(source_file_filtered_no_date)
  
  # Extract necessary parameters
  n_cols = ncol(Cumulative_Returns)
  n_assets = n_cols
  
  #To ensure portfolio is always weighted at 100% at all times
  assert(length(asset_weights) == n_assets)
  assert(abs(sum(asset_weights)-1) <= 0.001)
  
  portfolio_returns = data.matrix(source_file_filtered_no_date) %*% asset_weights
  cumulative_portfolio_returns = data.matrix(Cumulative_Returns) %*% asset_weights
  
  total_return = cumulative_portfolio_returns[[nrow(Cumulative_Returns),1]]
  annualized_vol = sd(portfolio_returns)*(52^0.5)
  g = paste("For Custom Portfolio between", customrange[1],"and",customrange[2],":",
            "Total return: ",round(total_return,1),"%,",
            "Annualized vol: ",round(annualized_vol,1),"%")
  print(g)
}

#########################
emf_portfolio_returns = function(asset_weights, returns_matrix)
{
  # Extract necessary parameters
  n_rows = nrow(returns_matrix)
  n_cols = ncol(returns_matrix)
  n_assets = n_cols - 1
  
  portfolio_returns = data.matrix(returns_matrix[,2:n_cols]) %*% asset_weights
  portfolio_returns_with_dates = cbind(returns_matrix[,1], portfolio_returns)
  
  return(portfolio_returns_with_dates)
}

#########################
calculate_cumulative_return = function(returns_vector)
{
  return(100*(prod(1 + returns_vector / 100) - 1))
}

#########################
plot_emf = function(n_points, target_vol, portfolio_selection)
{
  a = source_file %>%
    select(Date, portfolio_selection)
  
  asset_returns = a
  # Extract necessary parameters
  n_assets = ncol(asset_returns) - 1
  n_obs = nrow(asset_returns)
  n_years = n_obs / 52
  
  # Initialize containers for holding return and vol simulations
  return_vector = c()
  vol_vector = c()
  sharpe_vector = c()
  
  for (i in 1:n_points)
  {
  # Generate random weights for n assets from uniform(0,1)
  asset_weights = runif(n_assets, min = 0, max = 1)
  normalization_ratio = sum(asset_weights)
  # Asset weights need to add up to 100%
   
  asset_weights = asset_weights / normalization_ratio
  # print(asset_weights)
  # print(asset_returns)
  
  # Generate the portfolio return vector using these weights
  random_portfolio_returns = emf_portfolio_returns(
    asset_weights,
    asset_returns)
  # print(random_portfolio_returns)
  # plot_returns_histogram(random_portfolio_returns$portfolio_returns)
  
  cumulative_return = calculate_cumulative_return(random_portfolio_returns$portfolio_returns)
  annualized_return = 100*((1 + cumulative_return/100)^(1/n_years) - 1)
  annualized_vol = sd(random_portfolio_returns$portfolio_returns)*(52^0.5)
  sharpe = annualized_return / annualized_vol
  
  return_vector = append(return_vector, annualized_return)
  vol_vector = append(vol_vector, annualized_vol)
  sharpe_vector = append(sharpe_vector, sharpe)
  
  #print(paste("Asset weights:",asset_weights))
  #print(paste("Anualized return:",annualized_return))
  #print(paste("Annualized vol:",annualized_vol))
  }
  
  g = ggplot(data = data.frame(vol_vector, return_vector, sharpe_vector),
             aes(x = vol_vector, y = return_vector, color = sharpe_vector)) +
    scale_color_gradient(low = "red", high = "blue", name = "Sharpe Ratio\n(Return/Risk)") + 
    ggtitle("Efficient Market Frontier") +
    xlab("Annualized Vol (%)") +
    ylab("Annualized Return (%)") + 
    theme(plot.title = element_text(hjust=0.5)) + geom_vline(xintercept=target_vol) +
    geom_point()
  print(g) 
}  

