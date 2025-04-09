console.log(' main JS loaded')

// function addChildModal() {
//   var modal = document.getElementById('myModal')
//   var closeBtn = document.getElementsByClassName('close')[0]
//   modal.style.display = 'block'
//   closeBtn.onclick = function () {
//     modal.style.display = 'none'
//   }
//   window.onclick = function (event) {
//     if (event.target === modal) {
//       modal.style.display = 'none'
//     }
//   }
// }
// document.addEventListener('turbo:load', () => {
//   addChildModal()

//   const form = document.getElementById('account-form')

//   if (form) {
//     form.addEventListener('submit', async (event) => {
//       event.preventDefault()

//       const data = new FormData(form)

//       try {
//         const res = await fetch('accounts/create_child_user', {
//           method: 'POST',
//           body: data
//         })

//         const resData = await res.json()

//         console.log(resData)

//         if (resData.status === 'success') {
//           window.location.href = '/accounts'
//         }
//       } catch (err) {
//         console.error('Error:', err)
//       }
//     })
//   }
// })
