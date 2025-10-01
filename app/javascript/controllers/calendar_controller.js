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
        eventEl.className = 'flex flex-col p-2 rounded-lg border border-gray-200 shadow-sm hover:shadow-md transition-all duration-200 bg-white'
      
        const timeEl = document.createElement('div')
        timeEl.className = 'text-xs font-semibold text-gray-500'
        timeEl.textContent = timeText
      
        const coachEl = document.createElement('div')
        coachEl.className = 'font-medium truncate text-gray-800'
        coachEl.textContent = coachName
      
        const groupEl = document.createElement('div')
        groupEl.className = 'text-xs text-gray-400 truncate'
        groupEl.textContent = groups.replace(/^,\s*/, '')
      
        eventEl.appendChild(timeEl)
        eventEl.appendChild(coachEl)
        eventEl.appendChild(groupEl)
      
        return { domNodes: [eventEl] }
      },
      eventDidMount: (info) => {
        console.log("Event data:", info.event)
        if (info.event.backgroundColor) {
          info.el.style.backgroundColor = info.event.backgroundColor
          info.el.style.borderColor = info.event.borderColor || info.event.backgroundColor
          info.el.style.color = '#333'
        
          const dotEl = info.el.querySelector('.fc-event-dot')
          if (dotEl) {
            dotEl.style.backgroundColor = info.event.backgroundColor
          }
        
          const titleEl = info.el.querySelector('.fc-event-title')
          if (titleEl) {
            titleEl.style.color = '#333'
          }
        }
        
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