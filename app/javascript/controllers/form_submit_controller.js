import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect(){
    // console.log(this.element)
  }

  submit() {
    this.element.submit();
    console.log("rating submitted")
  }
}
