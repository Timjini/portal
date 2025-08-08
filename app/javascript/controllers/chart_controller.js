// app/javascript/controllers/chart_controller.js
import { Controller } from '@hotwired/stimulus'
import { Chart, registerables } from 'chart.js'

Chart.register(...registerables)

export default class extends Controller {
  static values = {
    data: Object,
    label: String,
    color: String
  }

  connect() {
    const ctx = this.element.getContext('2d')

    const labels = Object.keys(this.dataValue)
    const values = Object.values(this.dataValue)

    new Chart(ctx, {
      type: 'line',
      data: {
        labels: labels,
        datasets: [
          {
            label: this.labelValue || 'Activity',
            data: values,
            borderWidth: 2,
            borderColor: this.colorValue || '#3B82F6',
            tension: 0.3,
            fill: true,
            backgroundColor: 'rgba(59, 130, 246, 0.1)'
          }
        ]
      },
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              precision: 0
            }
          }
        },
        plugins: {
          legend: {
            display: true
          }
        }
      }
    })
  }
}
