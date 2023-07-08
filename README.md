# Finance Dashboard built using RShiny

The `CSV` included contains the data we are using for the project.

The `global.R` file is where the core logic of the data processing is held.

`app.R` calls on `global.R` for data and provides UI elements and other visualization specific code.

## How to Run

Open both `app.R` and `global.R` in **RStudio** and install all packages and dependencies.

Navigate back to `app.R` and hit 'run app' in the top right corner

![image](https://lh3.googleusercontent.com/pw/AIL4fc8YZslLTHExzXPWxL37rw-gBMRRvzyPFZOdmKWMECL34xYdGJ_LUTKQeyr3mxiRl1mf3qum4WqI9PG63oGpZ2IsTDmr3S9SlcbISxag4bl_nsw0MEQeRDu63JiqmwVHQQjEQdMY_IWLiVWBMVhE20LFz7Jl-3ln4X50pJcwSVvzNwB6MkinW3PsyGrGdb3d5Rr1_Wh-fzZyN-bN_L6jLlLDozxD16tzqUKt7c2KheOxum-ltnPYeiMKC14ioFqdj7HWyX7LThNgwEh-upC1KKic9UBNpqtb9zNPZwqSzo8r9Dn7NW13L7_LX5QPuGzqGvPyeErJSQJNt3hbjM9NqqHWiFJ05f7JN666VAh2at-NXBjmg2Acc2W0-41UgaP-LVwIWAjFGxlCAibOxHEGPGKaTiHCH0Bht_7VFOWkho8umlqvydlVLLERiLWOcaOwXfvGQhSv66GHC8bhIRYnjyddXmuPCZEM-iCkqKkqFPYGaMQ8k-84B4fcnz6LFYF1MqH3yqIMN1ag7iKVIxSPPbA0SnsLDldIocPqTtH8rujxIYBAEfU1iy8wGZp4_odbNRG6lov_x5SdW0Kuvrg2wOqn8WXg84Q0EgVb5uKSFE7mzzhn6J1Dv0YJK0krh25na7yqQpJiPg8BVZW-1Jxgyf78V3-9KCQRGRxeW7LCa-cdvebegzeGJu--Zmb4w9SftUfDy4Zipg4T5XCKRtF0knxkXRsKrTZplvcIoZYCW26nAPudXFRpfh_VzC4yGPk9zpZqitGPexM3V19UOEN1uakNEW6HzRDDSvBqiUmhH6dCOTUtPYSQ6uCXad33ofPSTqUaYlUC4pKmG-wwC7atvTX5ZguIE1G75IhUne0Al4uo-1pKgWgcLTl6FHo3uRb4SK46OH2VZyxZjLTQqkMSyMp8mNnI9_UuqamtTDkctARBCCMY_NcXoXFEvmL3iD_7YD-j-Fzc7OMoOCAC0TSyv8WWgBG2q77Iuec=w1290-h968-s-no?authuser=0)

It will load up this screen where you click on the data file you have. This csv has the cleaned and collated index values for each of the major global indices across a specified period of time.

![image2](https://lh3.googleusercontent.com/pw/AIL4fc9hcCm8PwYEY75-lp-RzwpmgvHdL5o-3uzZLvJnHoFD39BMrnW2EHEKbPD6e-0otwIuLin_Al9kySESnGvowkYUud7v-wF89oSniLToh0ZqKXh-3nwP2diwN6xQGEq6w6U5ashPcUNezXpriu4jQJ1uQarfaphSqWo_m10ujZK37LJ5ykTTfWk-ZxiR296lAD4eb0D0dsoyuSr_5V6HwUejF3vJikHNsuRqgkNpZpniF1_Hcij8XjiZS0q8oDh7aRvJCQs4_YGFjG7K5btzc4UdxmMcEKua5Hd-YIElY69NxCLa0X776HAy36E4V1odTdI325p-wOyoD8Pfy4Y5gW427Ky5pSa4OYk0zsEe1WgTlgnqL7adREggzQPhWPkcdT01SUClmxrbtAVZX3IRuyRyLvK3z7OWdCQDoZ3XoXs_HkL8kXZIhTVSXpWdxsRE0gpwVjwt4XWDj4n_R7XrRvwyc2vmNoU2QKhfQorQgDHxvGTQpqqy76x0I8XoZJnjmRyjmwPDQgFqQ39hp8FCiMtZft3LQkqw1C4PMXydj3Sm3TSGhtIE0glAKyJlWGzUOPO7v3Jr6hDDyq4sPc5KHXHrXhKjNKcIGghrDPIS4peEZ7Bs-DrqvEuWMSW7iBG_IbEPniUYEp6OIGHVXmsHq93mPP5hTUNzAfQfX6on6Z-gxjrYwwe9UW3D8RgUxKWCwPOz6pDKymQ4XiphqX7Gr8Rx_vGBdgRKVPimgUcEUrpzieFrGouwsTu6545qDHbJe_pBz0tL93r2-dz4RvR-X8N8x5jvUp9WaXVkwefMFCqlNTDibTgnqof3w_bYkvKoHwLzUW2QPEgBiU2Z2WC3gKMeOt6xry73ldeLB6CZkLwShkhQ4fwsOqzv46EGqY4cqfxIhnE-HiOh9IMaAqduXWJbbh3IhNL294GF6V6bOjyenz4hYx6CznFPpC3t_AMWgtLZ40Nh-4q0QzGcdxDAQhr48qWqBJIvcEk=w1780-h1024-s-no?authuser=0)

## Goals and Updates
The focus of this project was to come up with a way to visualize the correlation of various global indices, observe periods of drawdown, attempt to model what a custom portfolio of these indices might have historically returned as well as find a way to come up with a portfolio matching our target volatility

This project was completed in 2021 with my friend Natthanon as part of our internship and was built off pre-existing projects by multiple users such as pmaji (https://github.com/pmaji/financial-asset-comparison-tool).

The codebase is not actively maintained and is only put up here for educational purposes. If there are any breaking updates to R/RStudio or the above libraries, you can reach out to me via email to notify me and I'll try to update the code.
