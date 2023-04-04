import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log(this.element.elements)
    this.element.addEventListener('turbo:submit-end', () => {
      document.getElementById('close-modal-btn').click()
      this.element.reset()
    })
  }
}
