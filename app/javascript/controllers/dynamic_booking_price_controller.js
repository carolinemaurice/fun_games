import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = [ 'startDateInput', 'endDateInput', 'priceHolder', 'dates' ]
  static values = { price: Number }

  updatePrice() {
    const startDate = this.startDateInputTarget.value
    const endDate = this.endDateInputTarget.value

    const str = `${startDate} to ${endDate}`
    this.datesTarget.innerText = str

    const days = this.#diffInDays(startDate, endDate)

    const totalValue = this.#totalValue(days)

    this.#setPriceValue(totalValue)
  }

  #setPriceValue(value) {
    this.priceHolderTarget.innerText = value
  }

  #diffInDays(startDate, endDate) {
    if (startDate && endDate) {
      const diffTime = (Date.parse(endDate) - Date.parse(startDate))
      var days = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
    } else {
      var days = 0
    }
    return days + 1
  }

  #totalValue(days) {
    return (days) * this.priceValue
  }

  openCalendar() {
    this.startDateInputTarget.click()
  }
}
