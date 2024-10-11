# Pokedex
A simple mobile app that sends network requests to Pokemon API to render pokemon image using pagination technique.

# Platform
Please make sure you are running this project on XCode 16.0, iOS 18.0 and Swift 6.0.

# Challenges 
I think the hardest part of this project was figuring out how to deserialize and parse the correct type of data from JSON into Swift structs. The pagination took some time to implement because we needed to perform it only when the user was at the very last items. I designed it to fetch new items only when there were about five items left in the array and added a 0.1-second delay to prevent overloading the server. There was a lot of optional data to handle in case we didn't receive any data or if there was missing data from the API.

I found that sometimes the async image would fail to load on the first attempt, so we needed to refetch it when it reached the failure phase in AsyncImagePhase. I figured out how to fix that through the Apple Developer Forum. The code was beautifully structured, wrapping ScrollView, LazyVGrid, ForEach, and LazyVStack for clarity. I purposely added spaces between different lines to make it more readable. Overall, it was a fun app to work on.

I didn’t implement image caching, as it requires strong experience with Combine and a deep dive into Apple Documentation. Trying to figure it out would likely take me more hours than I anticipated. I wish I could dedicate more time to this project, but I have exams to study for. If anyone has questions about any of the code I wrote for this project, please feel free to reach out.


# Video walkthrough

https://github.com/user-attachments/assets/3dd0c82d-4975-4219-93fc-0c2a53c6cd7d

