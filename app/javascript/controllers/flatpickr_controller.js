import { Controller } from "@hotwired/stimulus"

// Import flatpickr function
import flatpickr from "flatpickr"
// The range plugin is also needed in order to use two inputs
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

export default class extends Controller {
  // retrieve the targets from the DOM
  static targets = [ 'startDateInput', 'endDateInput' ]
  static values = { dates: Object }

  connect() {
    this.#initFlatPickr()
  }

  #initFlatPickr() {
    console.log(this.#options())
    flatpickr(this.startDateInputTarget, this.#options());
  }

  #options() {
    return {
      ...this.datesValue,
      enableTime: true,
      minDate: new Date(),
      mode: 'range',
      "plugins": [new rangePlugin({ input: this.endDateInputTarget})]
    }
  }
}
