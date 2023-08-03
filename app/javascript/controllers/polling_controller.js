import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['status'];
  static values = { interval: Number, url: String, cookiesReady: Boolean };

  connect() {
    if (this.hasStatusTarget) {
      this.startPolling();
    }
  }

  disconnect() {
    this.stopPolling()
  }

  async checkStatus() {
    try {
      const response = await fetch(this.urlValue);
      return response.json();
    } catch (error) {
      console.error('Error fetching status:', error);
      this.stopPolling();
      throw new Error('Failed to fetch status. Please check the server response.');
    }
  }

  async updateStatus() {
    let data = await this.checkStatus();
    this.statusTarget.textContent = data['cookies_status']
    data['cookies_ready'] && this.stopPolling();
  }

  startPolling() {
    if (this.cookiesReadyValue) return;

    this.pollingInterval = setInterval(() => {
      this.updateStatus();
    }, this.intervalValue || 10000);
  }

  stopPolling() {
    clearInterval(this.pollingInterval);
  }
}
