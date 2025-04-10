// app/javascript/controllers/calendar_controller.js
import { Controller } from "@hotwired/stimulus"
import { Calendar } from '@fullcalendar/core'
import dayGridPlugin from '@fullcalendar/daygrid'
import interactionPlugin from '@fullcalendar/interaction'

export default class extends Controller {
  static values = { userId: String }
  static targets = ["calendar"]

  connect() {
    if (!this.calendarTarget) {
      console.error("Calendar element not found.")
      return
    }

    this.calendar = new Calendar(this.calendarTarget, {
      initialView: 'dayGridMonth',
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,dayGridWeek'
      },
      timeZone: 'local',
      eventTimeFormat: { 
        hour: 'numeric',
        minute: '2-digit',
        hour12: true
      },
      events: `/coach_calendar/data/${this.userIdValue}`,
      plugins: [dayGridPlugin, interactionPlugin],
      dayMaxEvents: true, // allow "more" link when too many events
      eventContent: (arg) => {
        const timeText = arg.timeText
        const coachName = arg.event.extendedProps.coach || 'No coach'
        const groups = arg.event.extendedProps.groups || ''
        
        const eventEl = document.createElement('div')
        eventEl.className = 'fc-event-main flex flex-col p-1'
        
        const timeEl = document.createElement('div')
        timeEl.className = 'fc-event-time text-xs font-semibold'
        timeEl.textContent = timeText
        
        const titleEl = document.createElement('div')
        titleEl.className = 'fc-event-title flex flex-col'
        
        const coachEl = document.createElement('span')
        coachEl.className = 'font-medium truncate'
        coachEl.textContent = coachName
        
        const groupEl = document.createElement('span')
        groupEl.className = 'text-xs opacity-75 truncate'
        groupEl.textContent = groups.replace(/^,\s*/, '') // Remove leading comma
        
        titleEl.appendChild(coachEl)
        titleEl.appendChild(groupEl)
        
        eventEl.appendChild(timeEl)
        eventEl.appendChild(titleEl)
        
        return { domNodes: [eventEl] }
      },
      eventDidMount: (info) => {
        // Apply custom styling
        if (info.event.extendedProps.color) {
          info.el.style.backgroundColor = `${info.event.extendedProps.color}15`
          info.el.style.borderLeft = `3px solid ${info.event.extendedProps.color}`
          info.el.style.color = '#333'
          info.el.style.boxShadow = 'none'
        }
        
        // Add hover effect
        info.el.style.transition = 'all 0.2s ease'
        info.el.addEventListener('mouseenter', () => {
          info.el.style.transform = 'translateX(2px)'
          info.el.style.boxShadow = '0 2px 5px rgba(0,0,0,0.1)'
        })
        info.el.addEventListener('mouseleave', () => {
          info.el.style.transform = ''
          info.el.style.boxShadow = 'none'
        })
      },
      eventClick: (info) => {
        // Handle event clicks (e.g., open edit modal)
        window.location.href = info.event.url
      },
      loading: (isLoading) => {
        const spinner = document.querySelector('.refresh-calendar-spinner')
        if (spinner) {
          spinner.classList.toggle('animate-spin', isLoading)
        }
      }
    })

    this.calendar.render()
  }

  disconnect() {
    if (this.calendar) {
      this.calendar.destroy()
    }
  }

  refresh() {
    if (this.calendar) {
      this.calendar.refetchEvents()
    }
  }
}