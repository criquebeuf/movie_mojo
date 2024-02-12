import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  // connect() {
  //   console.log("Hello from questions controller")
  //   console.log(this.element)
  // }

  next() {
    this.element.classList.remove("previous");
    console.log("next")
  }

  previous() {
    this.element.classList.add("previous");
    console.log("previous")
  }

  storeData() {
    console.log("hello from storeData");
    console.log(this.element)
  }
}
