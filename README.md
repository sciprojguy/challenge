#  Traeger Coding Challenge

## Notes and things I would do differently with more time

* Add animated progress UI for downloads
* Make the image caching smarter to delete ones outside of the range we want.  Simple way to do this would be to grab the downloaded image URLs, strip off the last path component and delete the images not in that Set.
* Add a way to refetch the APODs in case the user sends the app into the background and doesn't bring it back for a few days; also, add a pull to refresh.
* Add an icon instead of the default placeholder
* Clean up the Combine code a bit.  Right now, this is hackathon quality.
* Grab listings and add them to the testing bundle (also add tests) to test the Codable parsing
* Maybe mock up the API for reproducible testing.
* Do a better job on the model layer, since with some care it can be a good example.
* Consider using a NavigationView/NavigationLink to do a standard list/detail UI, but the directions said "single page"
* Spend more time making it pretty.

