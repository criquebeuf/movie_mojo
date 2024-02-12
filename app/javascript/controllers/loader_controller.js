import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["spinning"]

  connect() {
    console.log("Let's load that screen chief!")
  }

  loadingPage(event){
    console.log("You clicked on next!")

    console.log(event)
    console.log(this.element.firstElementChild)
      this.element.firstElementChild.classList.remove("neat-screen")
      this.spinningTarget.classList.remove("d-none")
  }

}
