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

    // console.log(this.movieValue)

    // fetch everything in JSON format: accept and content-type
    // x-csrf-token is a security feature that the post request is really
    // coming from the page and not from someone outside
    fetch(myTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json", "Content-Type": "application/json", "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content },
      body: JSON.stringify(this.movieValue)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
  }
}
