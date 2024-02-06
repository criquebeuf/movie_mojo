import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["card", "button"]

  connect() {
    console.log("You are on the results controller with JS!")
  }

  mouseEnters(event){
    console.log("You entered!")
    this.buttonTarget.classList.remove("d-none")
  }

  mouseLeaves(event){
    this.buttonTarget.classList.add("d-none")
  }
}
