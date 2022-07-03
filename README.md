
**

## Test application of Chedli LAKHDHAR

**

The architecture used is **MVVM**.
I used **async await** for WS calls.

**HttpClient:** Responsable of calling the WSs.
 **Router:** Contains the endpoints.
 **ToiletService:** Calling the toilets related WSs.
 **ToiletMapper:** Mapping Toilet object from the DTO.
 **Navigator:** Handles the navigation between screen.

**Things to improve if I had more time:**

 - Implement unit tests
 - Handle errors
 - Improve the **GeoLocationManager**
 - Improve the architecture
 - Investigate more on the crash caused by MapKit

## PS: There is a CRASH when your are on the Details screen and you quit the App (Going to the iPhone Home Screen or switching to another app) caused by MapKit on a real device (debug mode) when there is a MapView presented.
