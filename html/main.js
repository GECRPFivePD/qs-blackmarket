$(function () {
    let LangData = {};

    function LoadTranslations() {
        $.post(`https://${GetParentResourceName()}/GetLangData`, JSON.stringify({}), function (lang) {
            LangData = lang.table[lang.current];
            document.getElementById("damage").innerHTML = LangData.BLACKMARKET_UI_DAMAGE;
            document.getElementById("firerate").innerHTML = LangData.BLACKMARKET_UI_FIRERATE;
            document.getElementById("accuracy").innerHTML = LangData.BLACKMARKET_UI_ACCURACY;
            document.getElementById("range").innerHTML = LangData.BLACKMARKET_UI_RANGE;
            document.getElementById("damage2").innerHTML = LangData.BLACKMARKET_UI_DAMAGE;
            document.getElementById("firerate2").innerHTML = LangData.BLACKMARKET_UI_FIRERATE;
            document.getElementById("accuracy2").innerHTML = LangData.BLACKMARKET_UI_ACCURACY;
            document.getElementById("range2").innerHTML = LangData.BLACKMARKET_UI_RANGE;
            document.getElementById("illegaltext").innerHTML = LangData.BLACKMARKET_UI_TITLE;
            document.getElementById("shoptext_2").innerHTML = LangData.BLACKMARKET_UI_TITLE2;
            document.getElementById("shoptext_y").innerHTML = LangData.BLACKMARKET_UI_TITLE3;
            document.getElementById("text_botton").innerHTML = LangData.BLACKMARKET_UI_SEE_WEAPONS;
            document.getElementById("text_botton2").innerHTML = LangData.BLACKMARKET_UI_SEE_ITEMS;
            document.getElementById("yes_text").innerHTML = LangData.BLACKMARKET_UI_YES;
            document.getElementById("no_text").innerHTML = LangData.BLACKMARKET_UI_NO;
            document.getElementById("back").innerHTML = LangData.BLACKMARKET_UI_ESCBACK;
            document.getElementById("back2").innerHTML = LangData.BLACKMARKET_UI_ESCBACK;
        });  
    }

    var isLeftMouseDown = false;
    var finish_menu = false;

    document.body.onmousedown = function(event) {
        if (event.button === 0) {
            isLeftMouseDown = true;
        }
    }
    
    document.body.onmouseup = function(event) {
        if (event.button === 0) {
            isLeftMouseDown = false;
        }
    }
    
    document.body.addEventListener('mousemove', function(event) {
        if (isLeftMouseDown) {
            var horizontalRotation = event.movementX * -0.2;
    
            window.$.post(`https://${GetParentResourceName()}/changeRotation`, JSON.stringify({
                horizontal: horizontalRotation,
            }));
        }
    });
    
    window.addEventListener('message', (event) => {
        var item = event.data;
        LoadTranslations();
        if (item.type == "1") {
            if (item.type2 == "show") {
                $(".rectangle-parent").show();
                $(".label_weapon").text(item.label);
                $(".b").text("$ " + item.price);
                var text_desc = item.desc
                $(".desc_text2").text(text_desc);
                if (item.element == "weapon") {
                    document.getElementById("textbuy").innerHTML = LangData.BLACKMARKET_UI_BUY_WEAPON;
                    $(".desc2").hide();
                    $(".desc").hide();
                    $(".stats").show();
                }else if (item.element == "item") {
                    document.getElementById("textbuy").innerHTML = LangData.BLACKMARKET_UI_BUY_ITEM;
                    $(".desc2").show();
                    $(".stats").hide();
                }
                    document.getElementById('damage_amount').style.width = item.Damage + '%';
                    document.getElementById('firerate_amount').style.width = item.Speed + '%';
                    document.getElementById('accuracy_amount').style.width = item.Accuracy + '%';
                    document.getElementById('range_amount').style.width = item.Range + '%';
            }  else if (item.type2 == "hide") {
                $(".rectangle-parent").hide();
            }
        } else if (item.type == "2") {
            if (item.type2 == "show2") {
                $(".intro").show();
            }  else if (item.type2 == "hide2") {
                $(".intro").hide();
            }
        } else if (item.type == "3") {
            if (item.type2 == "show3") {
                finish_menu = true;
                $(".finish").show();
                $(".backgroungbuy").show();
                $("#weaponname").text(item.label);

                $(".textfinish").html(`
                <div class="text__">
                    ${LangData.BLACKMARKET_UI_BUY}
                    <span id="priceweapon">
                    ${"$" + item.price}
                    </span>
                    ?
                </div>
            `);

                if (item.element == "weapon") {
                    $(".stats2").show();
                    $(".desc3").hide();
                }else if (item.element == "item") {
                    $(".desc3").show();
                    $(".desc").show();
                    $(".desc_text2").text(item.desc);
                    $(".stats2").hide();
                }
                document.getElementById('damage_amount2').style.width = item.Damage + '%';
                document.getElementById('firerate_amount2').style.width = item.Speed + '%';
                document.getElementById('accuracy_amount2').style.width = item.Accuracy + '%';
                document.getElementById('range_amount2').style.width = item.Range + '%';
            }  else if (item.type2 == "hide3") {
                finish_menu = false;
                var element = document.getElementById('finish');
                element.classList.add('popdown');
                setTimeout(function() {
                    element.classList.remove('popdown');
                    $(".finish").hide();
                    $(".backgroungbuy").hide();
                }, 300);
            }
        }

    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            if (finish_menu == true) {
                return;
            }else{
                window.$.post(`https://${GetParentResourceName()}/closeUI`, JSON.stringify({}));
                return;
            }
        }
    };

});
