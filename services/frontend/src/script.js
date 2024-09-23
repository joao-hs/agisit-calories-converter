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

  document.getElementById("main-input-form").addEventListener("submit", function(e) {
    let conversionValue = e.target.elements.lbsInput.value;
    e.preventDefault();
    animateScale();
    let dropDownValue = document.getElementById("conversionSelector");
    let value = dropDownValue.options[dropDownValue.selectedIndex].value;
    if (value === "toOunces") {
      let conversionToOunces = [];
      conversionToOunces.push(conversionValue * 16);
      let printedOunces = document.createElement("h1");
      printedOunces.textContent = `${
      conversionToOunces[conversionToOunces.length - 1]
    } Ounces`;
      document.getElementById("display-area").innerHTML = "";
      document.getElementById("display-area").appendChild(printedOunces);
    } else if (value === "toKilograms") {
      let conversionToKilograms = [];
      conversionToKilograms.push(conversionValue / 2.2046);
      let printedKilos = document.createElement("h1");
      printedKilos.textContent = `${
      conversionToKilograms[conversionToKilograms.length - 1]
    } Kilograms`;
      document.getElementById("display-area").innerHTML = "";
      document.getElementById("display-area").appendChild(printedKilos);
    } else {
      let conversionToGrams = [];
      conversionToGrams.push(conversionValue * 453.592);
      let printedGrams = document.createElement("h1");
      printedGrams.textContent = `${
      conversionToGrams[conversionToGrams.length - 1]
    } Grams`;
      document.getElementById("display-area").innerHTML = "";
      document.getElementById("display-area").appendChild(printedGrams);
    }
    e.target.elements.lbsInput.value = "";
  });
  // For ColorChange
  document
    .getElementById("conversionSelector")
    .addEventListener("change", function(e) {
    if (e.target.value === "toKilograms") {
      // Change color
      document.getElementById("bottom-piece").className.baseVal = "cls-1a";
      document.getElementById("main-body-dark").className.baseVal = "cls-1a";
      document.getElementById("main-body-light").className.baseVal = "cls-1b";
    } else if (e.target.value === "toOunces") {
      // Change color
      document.getElementById("bottom-piece").className.baseVal = "cls-1";
      document.getElementById("main-body-dark").className.baseVal = "cls-1";
      document.getElementById("main-body-light").className.baseVal = "cls-4a";
    } else {
      document.getElementById("bottom-piece").className.baseVal = "cls-2";
      document.getElementById("main-body-dark").className.baseVal = "cls-2";
      document.getElementById("main-body-light").className.baseVal = "cls-2a";
    }
  });
})(jQuery);