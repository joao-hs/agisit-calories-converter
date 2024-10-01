(function ($) {
  function animateScale() {
    // for Tween Timeline
    let weightScale = $("#weight-scale"),
      clockHand = $("#clock-hand"),
      scaleNeck = $("#scale-neck"),
      tl = new TimelineLite();

    // Adding Tweens
    tl.from(weightScale, 1.3, { ease: Bounce.easeOut, y: 15 });
    tl.from(scaleNeck, 1.3, { ease: Bounce.easeOut, y: 15 }, "-=1.3");
    tl.from(
      clockHand,
      1.3,
      { rotation: "-320", transformOrigin: "100% 0%" },
      "-=1.3"
    );
  }

  // Function to handle the conversion logic
  function handleConversion(e) {
    e.preventDefault(); // Prevent default form submission behavior
    let conversionValue = document.getElementById("inputBox").value;
    animateScale();
    let dropDownValue = document.getElementById("foodSelector");
    let value = dropDownValue.options[dropDownValue.selectedIndex].value;
    let displayArea = document.getElementById("display-area");

    // GET http://localhost/chicken?weight=conversionValue
    calories = fetch(
      "/" + value + // Remove the trailing slash
        "?" +
        new URLSearchParams({
          weight: conversionValue,
        }),
      {
        method: "GET",
      }
    )
      .then((response) => {
        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
        return response.json(); // Assuming backend returns JSON
      })
      .then((data) => {
        console.log("Ping response:", data); // Log response for testing
        displayArea.innerHTML = `<h1>${data} Calories</h1>`;
      })
      .catch((error) => {
        console.error("Error fetching /chicken/:", error);
      });
    
  }

  // Trigger conversion on form submit (Enter key)
  document
    .getElementById("main-input-form")
    .addEventListener("submit", function (e) {
      e.preventDefault();
      document.getElementById("convert-button").click(); // Trigger Convert button click on Enter
    });

  // Trigger conversion on Convert button click
  document
    .getElementById("convert-button")
    .addEventListener("click", handleConversion);

  
})(jQuery);
