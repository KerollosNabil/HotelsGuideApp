# HotelsGuideApp


## Application Architecture Diagram

<img src="Hotels Guide.png"/>

## this app contains:-
* ### Data Managment Layer 
    this layer is isolated from the applecation logic and data types
    *  **Cache Backed Data Store** <br>
        this fremework provide protocoles lo manage the data fetching and caching process
    *  **Networking Layer** <br>
        this framework provide the code require to request the data over the internet 
    * **Request Builder** <br>
        this framework builds the request for us and the framework build with <ins>**Builder Design Pattern**</ins>
* ### Application Data Layer
    this layer is build over the previous one to translate the protocols and logic to be used with our app logic and data types
    * **Image Cache Back Data Store** <br>
        this framework implements the under layers Cache Backend Data Store his duty is to fetch images and cache it and retrieve it when it needed again
    * **Hotels Fetcher** <br>
        fetch hotels from internet using the endpoint enum
* ### application layer (View Controllers)
    this layers contains the view controllers and feed with data from the previous layer

## Application Pros
* ### testable 
    i used protocols to puild each struct and class which means the code is heily testable and i started the implemintation using <ins>**TDD**</ins> and for the sake of time i started to implement without testing <ins>**The first layer is almot all tested**</ins>
* ### Maintainability
    the code is consist of layers each layer is independent from the other and can be easily modified or replaced


## Aplication Cons
* ### UI Design 
    i am not a very good designer but i can easily implement any design with the best possible efficiency


<img src="demo.gif" width=200/>


### <ins>**Note:**</ins> i used a lot of ways implementing this app to show you that i can follow any way that the team use (interface Builder or programmerly)




## Refrences:
https://www.donnywals.com/building-flexible-components-with-generics-and-protocols/
https://www.donnywals.com/architecting-a-robust-networking-layer-with-protocols/
https://medium.com/flawless-app-stories/building-urlrequests-with-ease-f0136cdd56c3
https://blog.usejournal.com/building-a-safe-modularized-and-well-structured-networking-layer-in-swift-4-2-de264d079ce2
https://medium.com/flawless-app-stories/reusable-image-cache-in-swift-9b90eb338e8d

    