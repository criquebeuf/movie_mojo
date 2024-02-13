import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["answer"]

  next() {
    // for animation
    this.element.classList.remove("previous");

    // console.dir(this.answerTarget)

    // this.answerTarget = localStorage.getItem("answer");

    // if (localStorage.getItem("baseURI") === this.element.baseURI) {
    //   console.log("helloooo, I am the same")
    // }
  }

  previous() {
    // for animation
    this.element.classList.add("previous");
    console.log("previous")

    localStorage.setItem("answer", this.answerTarget.value);
  }

  storeData() {
  //   console.dir(this.answerTarget);

  //   console.log(localStorage.getItem("baseURI"));
  }
}
