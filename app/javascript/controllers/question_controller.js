import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["answer", "fill"]
  static values = {
    qindex: Number
  }

  connect() {
    console.log(this.qindexValue)

    const dots = this.fillTarget.getElementsByClassName("dot");
    var question_index = this.qindexValue + 1
    // console.log(dots)
    // console.log(event.target.dataset.qindex)

    // getElementsByClassName provides HTML collection instead of array
    // so we need to convert it to an array with Array.from()
    Array.from(dots).forEach((dot) => {
      if (question_index > 0) {
        dot.classList.add("completed");
        question_index--
      }
    });
  }

  next() {
    // for animation
    this.element.classList.remove("previous");
  }

  previous() {
    // for animation
    this.element.classList.add("previous");
  }

  storeData() {
    // was just for testing to store data for unfinished questions
    // console.dir(this.answerTarget);

    // console.log(localStorage.getItem("baseURI"));
  }
}
