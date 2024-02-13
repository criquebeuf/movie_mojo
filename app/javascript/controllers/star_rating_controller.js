import { Controller } from "@hotwired/stimulus"
import StarRating from "star-rating.js"

export default class extends Controller {

  static targets = ["rater"]

  connect() {
    new StarRating(this.element)
  }

  submit() {
    this.raterTarget.submit();
  }
}
