(function($) {
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

    if (value === "chicken") {
      let conversionToOunces = conversionValue * 16;
      displayArea.innerHTML = `<h1>${conversionToOunces.toFixed(2)} Calories</h1>`;
    } else if (value === "rice") {
      let conversionToKilograms = conversionValue / 1000; // Convert grams to kilograms
      displayArea.innerHTML = `<h1>${conversionToKilograms.toFixed(2)} Calories</h1>`;
    } else {
      let conversionToGrams = conversionValue * 1; // Assuming the input is in grams already
      displayArea.innerHTML = `<h1>${conversionToGrams.toFixed(2)} Calories</h1>`;
    }

  }

  // Trigger conversion on form submit (Enter key)
  document.getElementById("main-input-form").addEventListener("submit", function(e) {
    e.preventDefault();
    document.getElementById("convert-button").click(); // Trigger Convert button click on Enter
  });

  // Trigger conversion on Convert button click
  document.getElementById("convert-button").addEventListener("click", handleConversion);

  // Color change logic when selecting food type
  document
    .getElementById("foodSelector")
    .addEventListener("change", function(e) {
      if (e.target.value === "rice") {
        // Change color for rice
        document.getElementById("bottom-piece").className.baseVal = "cls-1a";
        document.getElementById("main-body-dark").className.baseVal = "cls-1a";
        document.getElementById("main-body-light").className.baseVal = "cls-1b";
      } else if (e.target.value === "chicken") {
        // Change color for chicken
        document.getElementById("bottom-piece").className.baseVal = "cls-1";
        document.getElementById("main-body-dark").className.baseVal = "cls-1";
        document.getElementById("main-body-light").className.baseVal = "cls-4a";
      } else {
        // Change color for other options
        document.getElementById("bottom-piece").className.baseVal = "cls-2";
        document.getElementById("main-body-dark").className.baseVal = "cls-2";
        document.getElementById("main-body-light").className.baseVal = "cls-2a";
      }
    });
})(jQuery);
