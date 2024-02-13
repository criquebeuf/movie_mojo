import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-to-watchlist"
export default class extends Controller {
  static values = { movie: Object }

  connect() {
    // console.log("hello from watchlist");
    // console.log(this.itemsTarget)
  }

  add(event) {
    event.preventDefault();

    // Take the form created by button_to in the view
    const myTarget = this.element.firstElementChild;
    // console.log(myTarget)

    // ANIMATION STUFF
    const submitButton = myTarget.getElementsByClassName("button-submit")[0];
    // console.log(submitButton);

    // fetch everything in JSON format: accept and content-type
    // x-csrf-token is a security feature that the post request is really
    // coming from the page and not from someone outside
    fetch(myTarget.action, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content
      },
      body: JSON.stringify(this.movieValue)
    })
      .then(response => {
        // console.log(response)
        if (response.ok) {
          response.json()
          // show green check mark
          submitButton.classList.add("success");
        } else {
          // show red exklamation mark
          submitButton.classList.add("error");
        }
      })
      .then((data) => {
        console.log(data);
        animateButton(event);
      });
  }
}

var animateButton = function(e) {

  e.preventDefault;
  //reset animation

  e.target.classList.remove('animate');

  e.target.classList.add('animate');

  e.target.classList.add('animate');

  setTimeout(function(){
    e.target.classList.remove('animate');
  },6000);

};
