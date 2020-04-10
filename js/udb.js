// clicky
var clicky_site_ids = clicky_site_ids || []; clicky_site_ids.push(101246300);

// subscriber embed

function showMailingPopUp() {
  window.dojoRequire(["mojo/signup-forms/Loader"], function (L) { L.start({ "baseUrl": "mc.us19.list-manage.com", "uuid": "0c3e03a2482badc5c9c8958ab", "lid": "c82ae734c7", "uniqueMethods": true }) });
  document.cookie = 'MCPopupClosed=;path=/;expires=Thu, 01 Jan 1970 00:00:00 UTC;';
  document.cookie = 'MCPopupSubscribed=;path=/;expires=Thu, 01 Jan 1970 00:00:00 UTC;';
};

document.addEventListener("DOMContentLoaded", function (event) {
  document.querySelector('[title="Email"]').addEventListener("click", function (event) {
    event.preventDefault();
    showMailingPopUp();
  });
});
