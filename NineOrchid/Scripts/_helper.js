if ($.fn.datepicker) {
    $.fn.datepicker.defaults.dateFormat = "dd-mm-yyyy";
    $.fn.datepicker.defaults.autoclose = true;
    $.fn.dataTable.ext.errMode = 'none'; // suppress warning alert
}

if ($.fn.timepicker) {
    $.fn.timepicker.defaults.showMeridian = false; // 24 hour mode
    $.fn.timepicker.defaults.showSeconds = true;
}

if ($.validator) {
    $.validator.addMethod('unique', function (value, element, param) {
        if (this.optional(element)) {
            return "dependency-mismatch";
        }

        method = typeof method === "string" && method || "unique";

        var previous = this.previousValue(element, method),
            validator, data, optionDataString;

        if (!this.settings.messages[element.name]) {
            this.settings.messages[element.name] = {};
        }
        previous.originalMessage = previous.originalMessage || this.settings.messages[element.name][method];
        this.settings.messages[element.name][method] = previous.message;

        param = typeof param === "string" && { url: param } || param;
        if (param.__url.indexOf('{value}') > -1) param.url = param.__url.replace('{value}', value);

        optionDataString = $.param($.extend({ data: value }, param.data));
        if (previous.old === optionDataString) {
            return previous.valid;
        }

        previous.old = optionDataString;
        validator = this;
        this.startRequest(element);
        data = {};
        data[element.name] = value;
        $.ajax($.extend(true, {
            mode: "abort",
            port: "validate" + element.name,
            dataType: "json",
            data: data,
            context: validator.currentForm,
            success: function (response) {
                var valid = response.value.length == 0,
                    errors, message, submitted;

                validator.settings.messages[element.name][method] = previous.originalMessage;
                if (valid) {
                    submitted = validator.formSubmitted;
                    validator.resetInternals();
                    validator.toHide = validator.errorsFor(element);
                    validator.formSubmitted = submitted;
                    validator.successList.push(element);
                    validator.invalid[element.name] = false;
                    validator.showErrors();
                } else {
                    errors = {};
                    message = validator.defaultMessage(element, { method: method, parameters: value });
                    errors[element.name] = previous.message = message;
                    validator.invalid[element.name] = true;
                    validator.showErrors(errors);
                }
                previous.valid = valid;
                validator.stopRequest(element, valid);
            }
        }, param));
        return "pending";
    }, "Value is not unique. Please fix this field.");

    $.validator.classRuleSettings.unique = {
        'unique': true
    };

    $.validator.addMethod("latlong", function (value, element) {
        if (this.optional(element)) {
            return "dependency-mismatch";
        }
        var parts = String(value).split('.');
        return (parts.length == 1 || parts[1].length <= 8)
    }, "You must include max 8 decimal places");

    $.validator.addMethod("number2", function (value, element) {
        return this.optional(element) || /^-?(?:\d+|\d{1,3}(?:[\s\.,]\d{3})+)(?:[\.,]\d+)?$/.test(value);
    }, 'Please enter a valid number');

    $.validator.setDefaults({
        'ignore': ':hidden, [readonly=readonly]'
    });
}

function initForm(form, submitHandler) {
    if (submitHandler) {
        form.validate({
            'submitHandler': submitHandler,
            'highlight': function (element, errorClass, validClass) {
                $(element).parents(".form-group").addClass("has-error").removeClass("has-success");
                $(element).next("span").addClass("glyphicon-remove").removeClass("glyphicon-ok");
            },
            'unhighlight': function (element, errorClass, validClass) {
                $(element).parents(".form-group").addClass("has-success").removeClass("has-error");
                $(element).next("span").addClass("glyphicon-ok").removeClass("glyphicon-remove");
            }
        });
    }
    /* special treatment for file */
    $('input[type=file]', form).change(function(evt) {
        var fileReader = new FileReader();
        fileReader.onload = function (readerEvt) {
            var content = $('[name="' + $(evt.target).attr('name') + '_CONTENT"]', form);
            if (content.length == 0) {
                var content = $('<input name="' + $(evt.target).attr('name') + '_CONTENT" type="hidden" class="exclude"/>');
                $(evt.target).closest('form').prepend(content);
            }
            content.val(btoa(readerEvt.target.result));
        };
        fileReader.readAsBinaryString($(this)[0].files[0]);
    })
    /* */
}

function serializeForm2(form) {    
    var o = {};
    var a = form.serializeArray();
    $(a).each(function () {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    
    return o;

}

function serializeForm(form) {
    var obj = {};
    $('input[type=text]:enabled,select:enabled,input[type=number]:enabled,input[type=hidden],input[type=email],input[type=checkbox],input[type=file],input[type=datetime],input[type=radio]:checked,textarea:enabled', form).not('[readonly]').not('.exclude').each(function () {
        if (!isEmptyString($(this).val()) && $(this).val().toLowerCase() != 'submit') {
            obj[$(this).attr('name')] = $(this).val();
            /* special treatment for datepicker & timepicker */
            if ($(this).attr('data-provide') == 'datepicker') {
                if ($(this).val().indexOf('-') == 2) { // reverse if date value hasn't been reversed
                    obj[$(this).attr('name')] = $(this).val().split('-').reverse().join('-');
                }
                $(this).closest('form').data('last-datepicker', obj[$(this).attr('name')]); // store datepicker for the following timepicker
            }
            if ($(this).attr('data-provide') == 'timepicker') {
                if ($(this).closest('form').data('last-datepicker')) {
                    var val = $(this).val();
                    if(val.indexOf(':') == 1) val = '0'+val; // leading zero
                    obj[$(this).attr('name')] = $(this).closest('form').data('last-datepicker') + 'T' + val; // format as datetime using last datepicker
                }
            }
            if (typeof $(this).data('DateTimePicker') == 'object') {
                if ($(this).data('DateTimePicker').format() == 'DD-MM-YYYY') {
                    obj[$(this).attr('name')] = moment($(this).val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                } else if ($(this).data('DateTimePicker').format() == 'DD-MM-YYYY HH:mm') {
                    obj[$(this).attr('name')] = moment($(this).val(), 'DD-MM-YYYY HH:mm').format('YYYY-MM-DDTHH:mm');
                }
            }
            if ($(this).attr('type') == 'checkbox')
            {
                obj[$(this).attr('name')] = $(this).is(":checked")==true?1:0;
            }
            /* */
            /* special treatment for file */
            if ($(this).attr('type') == 'file' && !isEmptyString($('input[name=' + $(this).attr('name') + '_CONTENT]').val())) {
                obj[$(this).attr('name')] = $(this).val().split('.').pop() + '|' + $('input[name=' + $(this).attr('name') + '_CONTENT]').val();
                //console.log(obj[$(this).attr('name')]);
            }
            /* */
        }
        //console.log($(this).attr('type'));
    })
    return obj;
}

function fillForm(form, obj, notrecursive) {    
    for (var f in obj) {
        if (typeof obj[f] != 'object') {
            if ($('[name="' + f + '"]', form).length && !isEmptyString(obj[f])) {
                var elm = $('[name="' + f + '"]', form);                
                if (elm.attr('data-provide') == 'datepicker') { // datepicker
                    //console.log(elm.datepicker('format'));
                    elm.val(renderDate(obj[f])); // show yyyy-mm-dd only
                    elm.datepicker('setDate', renderDate(obj[f]));

                } else if (elm.attr('data-provide') == 'timepicker') { // timepicker
                    elm.val(renderTime(obj[f])); // show time only
                    elm.timepicker('setTime', renderTime(obj[f]));

                } else if (typeof elm.data('DateTimePicker') == 'object') { // datetimepicker
                    if (elm.data('DateTimePicker').format() == 'DD-MM-YYYY') {
                        elm.val(moment(obj[f], 'YYYY-MM-DD').format('DD-MM-YYYY'));
                    } else if (elm.data('DateTimePicker').format() == 'DD-MM-YYYY HH:mm') {
                        elm.val(moment(obj[f], 'YYYY-MM-DDTHH:mm').format('DD-MM-YYYY HH:mm'));
                    } else if (elm.data('DateTimePicker').format() == 'HH:mm') {
                        elm.val(moment(obj[f], 'YYYY-MM-DDTHH:mm').format('HH:mm'));
                    }

                } else if (elm.attr('type') == 'checkbox') {
                    elm.prop('checked', obj[f]);
                } else {
                    elm.val(obj[f]);
                }

                elm.data('initValue', elm.val()); // store initial value for change checking

                if (elm.get(0).tagName.toLowerCase() == 'select') {
                    if ($('option[value="' + obj[f] + '"]', elm).length == 0) {
                        elm.data('value', obj[f]); // store temporary value, options has not loaded yet
                    } else {
                        $('option[value="' + obj[f] + '"]', elm).prop('selected', true);
                        elm.triggerHandler('change'); // trigger change if options loaded
                    }
                    elm.data('initValue', obj[f]); // store initial value for change checking
                    //console.log(elm);
                }
            }
        } else if(!notrecursive) {
            fillForm(form, obj[f]); // recursive, watch out duplicate field name !
        }
    }
    $('.datepicker').datepicker('update');
}

function resetForm(form) {
    $(form).validate().resetForm();
    $(form).trigger('reset');
    $(form).validate().resetForm();
    $(form).find('.has-error').removeClass("has-error");
    $(form).find('.has-success').removeClass("has-success");
    $(form).find('.form-control-feedback').remove();
    $('input[data-provide=datepicker]', form).datepicker('update', '');
    $('input[type=text]:enabled,select:enabled,input[type=number]:enabled,input[type=hidden],input[type=file]', form).not('[readonly]').not('.exclude').removeData('initValue');
    $(form).get(0).reset();
    $('input', form).filter(function (i) { return !isEmptyString($(this).data('masked')) }).removeData('masked-value');
}

function disableForm(form, state, exclude) {
    if (state) {
        form.find("input:not(:disabled), select:not(:disabled)").not(exclude).attr('form-disabled', true).prop("disabled", true);
    }
    if (!state) {
        form.find("[form-disabled]").not(exclude).removeAttr('form-disabled').prop("disabled", false);
    }
}

function formHasChange(form) {
    var changed = false;
    $('input[type=text]:enabled,select:enabled,input[type=number]:enabled,input[type=hidden],input[type=file]', form).not('[readonly]').not('.exclude').each(function () {
        if ($(this).data('initValue') != $(this).val() && !(isEmptyString($(this).data('initValue')) && isEmptyString($(this).val()))) {
            //console.log($(this).attr('name') + ' ' + $(this).data('initValue') + ' ' + $(this).val());
            changed = true;
        }
    })
    return changed;
}


function fillSelectAPI(elm, url, param, def,defIndex) {
    var rowcount = 0
    var defaultProp = elm.prop('disabled');
    elm.empty();
    elm.attr('disabled', true);
    if (elm.next('span.glyphicon').length == 0) $('<span class="glyphicon glyphicon-refresh spinning" style="position:absolute;top:5px;left:' + (elm.outerWidth() + 20) + 'px"></span>').insertAfter(elm); // add preloader
    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        success: function (item) {
            rowcount = item.length;
            elm.append('<option value=""> </option>');
            // if (!elm.prop('required')) elm.append('<option value=""> </option>'); // provide blank option if not mandatory
            $.each(item, function (key, val) {
                if ($('option[value="' + val[param.field_value] + '"]', elm).length == 0 || !param.uniq_value) {
                    //console.log(typeof (param.field_label));
                    switch (typeof (param.field_label)) {
                        case 'string':
                            if (param.field_label.indexOf('}') != -1 && param.field_label.indexOf('{') != -1) {
                                var label = param.field_label;
                                for (var f in val) {
                                    if (label.indexOf('{' + f + '}') != -1) {
                                        label = label.replace('{' + f + '}', val[f]);
                                    } else if (label.indexOf('{' + f + '.') != -1 && typeof val[f] == 'object') {
                                        var npos = label.indexOf('{' + f + '.');
                                        var nlabel = label.substring(npos + 1, label.indexOf('}', npos));
                                        var narr = nlabel.split('.');
                                        var nval = val[f]
                                        for (var n = 1; n < narr.length; n++) {
                                            nval = nval[narr[n]];
                                        }
                                        label = label.replace('{' + nlabel + '}', nval);
                                    }
                                }
                            } else {
                                var label = val[param.field_label];
                            }
                            break;
                        case 'function':
                            var label = param.field_label(val);
                            break;
                    }

                    elm.append('<option value="' + val[param.field_value] + '">' + label + '</option>');
                }
            });
            if (elm.data('value')) {
                //console.log(elm.data('value'));
                elm.val(elm.data('value')); // restore value from temporary
                elm.data('value', null); // clear temporary value
                elm.triggerHandler('change'); // trigger change after loaded
            }
            if (param && typeof (param.callback) == 'function') {
                param.callback(item, elm);
            }
            elm.attr('disabled', defaultProp);
            elm.next('span').remove(); // remove preloader
        },
        error: function (event, textStatus, errorThrown) {
            alert("Message : Javasript or your connection is disabled or not connected ");
        },
        complete: function () {

            if (def != null || def != undefined) {
                elm.val(def);
            }

            if (defIndex != null || defIndex != undefined) {
                elm.prop('selectedIndex', defIndex);
            }

            if (rowcount > 10) {
                elm.select2({ width: '100%' });
            }
        }
    });
}

function fillSelectAsync(elm, url, param, def) {
    var rowcount = 0
    var defaultProp = elm.prop('disabled');
    elm.empty();
    elm.attr('disabled', true);
    if (elm.next('span.glyphicon').length == 0) $('<span class="glyphicon glyphicon-refresh spinning" style="position:absolute;top:5px;left:' + (elm.outerWidth() + 20) + 'px"></span>').insertAfter(elm); // add preloader
    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        async: false,
        success: function (item) {
            rowcount = item.value.length;
            elm.append('<option value=""> </option>');
            // if (!elm.prop('required')) elm.append('<option value=""> </option>'); // provide blank option if not mandatory
            $.each(item.value, function (key, val) {
                if ($('option[value="' + val[param.field_value] + '"]', elm).length == 0 || !param.uniq_value) {
                    //console.log(typeof (param.field_label));
                    switch (typeof (param.field_label)) {
                        case 'string':
                            if (param.field_label.indexOf('}') != -1 && param.field_label.indexOf('{') != -1) {
                                var label = param.field_label;
                                for (var f in val) {
                                    if (label.indexOf('{' + f + '}') != -1) {
                                        label = label.replace('{' + f + '}', val[f]);
                                    } else if (label.indexOf('{' + f + '.') != -1 && typeof val[f] == 'object') {
                                        var npos = label.indexOf('{' + f + '.');
                                        var nlabel = label.substring(npos + 1, label.indexOf('}', npos));
                                        var narr = nlabel.split('.');
                                        var nval = val[f]
                                        for (var n = 1; n < narr.length; n++) {
                                            nval = nval[narr[n]];
                                        }
                                        label = label.replace('{' + nlabel + '}', nval);
                                    }
                                }
                            } else {
                                var label = val[param.field_label];
                            }
                            break;
                        case 'function':
                            var label = param.field_label(val);
                            break;
                    }

                    elm.append('<option value="' + val[param.field_value] + '">' + label + '</option>');
                }
            });
            if (elm.data('value')) {
                //console.log(elm.data('value'));
                elm.val(elm.data('value')); // restore value from temporary
                elm.data('value', null); // clear temporary value
                elm.triggerHandler('change'); // trigger change after loaded
            }
            if (param && typeof (param.callback) == 'function') {
                param.callback(item, elm);
            }
            elm.attr('disabled', defaultProp);
            elm.next('span').remove(); // remove preloader
        },
        error: function (event, textStatus, errorThrown) {
            alert("Message : Javasript or your connection is disabled or not connected ");
        },
        complete: function () {

            if (def != null || def != undefined) {
                elm.val(def);
            }

            if (rowcount > 50) {
                elm.select2({ width: '100%' });
            }
        }
    });
}

function fillSelect(elm, url, param, def) {
    var rowcount = 0
    var defaultProp = elm.prop('disabled');
    elm.empty();
    elm.attr('disabled', true);
    if(elm.next('span.glyphicon').length == 0) $('<span class="glyphicon glyphicon-refresh spinning" style="position:absolute;top:5px;left:'+(elm.outerWidth()+20)+'px"></span>').insertAfter(elm); // add preloader
    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        success: function (item) {
            rowcount = item.value.length;
            elm.append('<option value=""> </option>');
            // if (!elm.prop('required')) elm.append('<option value=""> </option>'); // provide blank option if not mandatory
            $.each(item.value, function (key, val) {                
                if ($('option[value="' + val[param.field_value] + '"]', elm).length == 0 || !param.uniq_value) {
                    //console.log(typeof (param.field_label));
                    switch(typeof(param.field_label)) {
                        case 'string':
                            if (param.field_label.indexOf('}') != -1 && param.field_label.indexOf('{') != -1) {
                                var label = param.field_label;
                                for (var f in val) {
                                    if (label.indexOf('{' + f + '}') != -1) {
                                        label = label.replace('{' + f + '}', val[f]);
                                    } else if (label.indexOf('{' + f + '.') != -1 && typeof val[f] == 'object') {
                                        var npos = label.indexOf('{' + f + '.');
                                        var nlabel = label.substring(npos + 1, label.indexOf('}', npos));
                                        var narr = nlabel.split('.');
                                        var nval = val[f]
                                        for (var n = 1; n < narr.length; n++) {
                                            nval = nval[narr[n]];
                                        }
                                        label = label.replace('{' + nlabel + '}', nval);
                                    }
                                }
                            } else {
                                var label = val[param.field_label];
                            }
                            break;
                        case 'function':
                            var label = param.field_label(val);
                            break;
                    }
                    
                    elm.append('<option value="' + val[param.field_value] + '">' + label + '</option>');
                }
            });
            if (elm.data('value')) {
                //console.log(elm.data('value'));
                elm.val(elm.data('value')); // restore value from temporary
                elm.data('value', null); // clear temporary value
                elm.triggerHandler('change'); // trigger change after loaded
            }
            if (param && typeof (param.callback) == 'function') {
                param.callback(item, elm);
            }
            elm.attr('disabled', defaultProp);
            elm.next('span').remove(); // remove preloader
        },
        error: function (event, textStatus, errorThrown) {
            alert("Message : Javasript or your connection is disabled or not connected ");
        },
        complete: function () {
            
            if(def!=null || def != undefined){
                elm.val(def);
            }

            if(rowcount>50){
                elm.select2({ width: '100%' });
            }
        }
    });
}

function fillSelectExpand(elm, url, param) {
    elm.empty();
    elm.attr('disabled', true);
    if (elm.next('span.glyphicon').length == 0) $('<span class="glyphicon glyphicon-refresh spinning" style="position:absolute;top:5px;left:' + (elm.outerWidth() + 20) + 'px"></span>').insertAfter(elm); // add preloader
    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        success: function (item) {
         
            elm.append('<option value=""> </option>');
            // if (!elm.prop('required')) elm.append('<option value=""> </option>'); // provide blank option if not mandatory
            $.each(item.value, function (key, val) {
              

                $.each(val.WELL, function (key1, valWell) {
                    debugger;
                    if ($('option[value="' + valWell[param.field_value] + '"]', elm).length == 0 || !param.uniq_value) {
                        if (param.field_label.indexOf('}') != -1 && param.field_label.indexOf('{') != -1) {
                            var label = param.field_label;
                            for (var f in valWell) {
                                debugger;
                                if (label.indexOf('{' + f + '}') != -1) {
                                    label = label.replace('{' + f + '}', valWell[f]);
                                } else if (label.indexOf('{' + f + '.') != -1 && typeof valWell[f] == 'object') {
                                    var npos = label.indexOf('{' + f + '.');
                                    var nlabel = label.substring(npos + 1, label.indexOf('}', npos));
                                    var narr = nlabel.split('.');
                                    var nval = valWell[f]
                                    for (var n = 1; n < narr.length; n++) {
                                        debugger;
                                        nval = nval[narr[n]];
                                    }
                                    label = label.replace('{' + nlabel + '}', nval);
                                }
                            }
                        } else {
                            var label = valWell[param.field_label];
                        }
                        elm.append('<option value="' + valWell[param.field_value] + '">' + label + '</option>');
                    }
                });                
            });
            if (elm.data('value')) {
                //console.log(elm.data('value'));
                elm.val(elm.data('value')); // restore value from temporary
                elm.data('value', null); // clear temporary value
                elm.triggerHandler('change'); // trigger change after loaded
            }
            if (param && typeof (param.callback) == 'function') {
                param.callback(item);
            }
            elm.attr('disabled', false);
            elm.next('span').remove(); // remove preloader
        },
        error: function (event, textStatus, errorThrown) {
            alert("Message : Javasript or your connection is disabled or not connected ");
        }
    });
}

function refreshTable(table, url, callback) {
    //debugger;
    if (url) {
        var obj = table.dataTable().fnSettings();
        obj.sAjaxSource = url;
        
    }
    var dtable = table.dataTable({ bRetrieve: true });
    //dtable.fnFilter('');
    dtable._fnDraw();
    table.DataTable().ajax.reload();
}

function renderDate(data, type, val) {
    if (!isEmptyString(data)) {
        return data.substr(0, 10).split('-').reverse().join('-'); // show yyyy-mm-dd only
    }
    return '';
}

function isEmptyString(str) {
    return ($.trim(str) === "");
}

function renderTime(data, type, val) {
    if (!isEmptyString(data)) {
        return data.substr(11); // show time only
    }
    return '';
}

function dateDiff(date1, date2) {
    date1.setHours(0);
    date1.setMinutes(0, 0, 0);
    date2.setHours(0);
    date2.setMinutes(0, 0, 0);
    var datediff = Math.abs(date1.getTime() - date2.getTime()); // difference 
    return parseInt(datediff / (24 * 60 * 60 * 1000), 10); //Convert values days and return value      
}

function odataQueryString(obj) {
    var arr = [];
    var str;
    for (var f in obj) {
        if (isNaN(obj[f])) {
            if (new Date(obj[f]) == "Invalid Date") {
                str = f + " eq '" + obj[f] + "'";
            } else {
                str = f + " eq datetime'" + obj[f] + "'";
            }
        } else {
            str = f + " eq " + obj[f];
        }
        /*if (f.indexOf('/') != -1) {
            var farr = f.split('/');
            str = farr[0] + '/all(c: c/' + str.replace(farr[0] + '/', '') + ')';
        }*/
        arr.push(str);
    }
    return arr.join (" and ");
}

function refreshForm(form, url, param) {

    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        contentType: "application/json",
        success: function (response) {
            resetForm(form);
            form[0].reset();
            fillForm(form, response);
            if (param && typeof (param.callback) == 'function') {
                param.callback(response);
            }
        },
        error: function (event, textStatus, errorThrown) {
            alert("Message : Javasript or your connection is disabled or not connected ");
        }
    });
}

function makeTable(data, isHtml) {
    var table = $("<table/>");
    $.each(data, function (rowIndex, r) {
        var row = $("<tr/>");
        $.each(r, function (colIndex, c) {
            if (isHtml) {
                row.append($("<td/>").html(c));
            } else {
                row.append($("<td/>").text(c));
            }
        });
        table.append(row);
    });
    return table;
}

function dynamicSort(property) {
    var sortOrder = 1;
    if (property[0] === "-") {
        sortOrder = -1;
        property = property.substr(1);
    }
    return function (a, b) {
        if (isNaN(a[property]) || isNaN(b[property])) {
            var result = (a[property] < b[property]) ? -1 : (a[property] > b[property]) ? 1 : 0;
        } else {
            var result = (Number(a[property]) < Number(b[property])) ? -1 : (Number(a[property]) > Number(b[property])) ? 1 : 0;
        }
        
        return result * sortOrder;
    }
}

var tableToExcel = (function () {
    var uri = 'data:application/vnd.ms-excel;base64,'
    , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
    , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) }
    , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }
    return function (table, name, filename) {
        if (!table.nodeType) table = document.getElementById(table)
        //console.log($(table).html());
        var ctx = { worksheet: name || 'Worksheet', table: $(table).html() }

        location = uri + base64(format(template, ctx));
        //document.getElementById(table).download = filename;
        //document.getElementById(table).click();

    }
})()

function dataTableActionButton(buttons) {
    var res = $('<center></center>');
    var tpl = $('<a class="btn btn-sm btn-default"></a>');
    var id = 0;
    for (var b in buttons) {
        var btn = tpl.clone();
        switch(buttons[b]['text']) {
            case 'Edit':
                btn.append('<span class="glyphicon glyphicon-pencil"></span>');
                break;
            case 'Delete':
                btn.append('<span class="glyphicon glyphicon-trash"></span>');
                break;
            case 'View':
                btn.append('<span class="glyphicon glyphicon-search"></span>');
                break;
            case 'Copy':
                btn.append('<span class="glyphicon glyphicon-copy"></span>');
                break;
            case 'Check':
                //btn.append('<input type="checkbox" >');
                btn.append("<input type='checkbox' id='cb_" + id + "' value='cb_val' name='cb_name' checked>");
                break;
            default :
                btn.text(buttons[b]['text']);
        }
        if (buttons[b]['disabled'] !== null) {
            btn.attr('disabled', buttons[b]['disabled']);
        }
        if (!buttons[b]['disabled'] && buttons[b]['onclick'] !== null) {
            btn.attr('onclick', buttons[b]['onclick']);
        }
        if (!buttons[b]['disabled'] && buttons[b]['href'] !== null) {
            btn.attr('href', buttons[b]['href']);
        }
        res.append(btn, '&nbsp;');
        id++;
    }
    return res.html();
}

function hasPermission(perm) {
    return ($.inArray(perm, permissions) != -1)
}

function setMasked(elm) {
    elm.each(function () {
        $(this).css('text-align', 'right').data('masked', true).focusin(function () {
            $(this).oriVal($(this).val());
        }).focusout(function () {
            $(this).val($(this).oriVal());
        }).rules('add', { number2: true });
    })
    $.validator.messages.number2 = 'Please enter a valid number';
    if ($.fn.oriVal == null) {
        $.fn.oriVal = $.fn.val;
        $.fn.val = function (value) {
            if (this[0]) var ele = $(this[0]);
            if (value != undefined) {
                if (ele && ele.data('masked')) {
                    if (!isEmptyString(value)) {
                        ele.data('masked-value', value.split(',').join(''));
                        return this.oriVal($.number(value, 2));
                    } else {
                        ele.data('masked-value', '');
                        return this.oriVal('');
                    }
                } else {
                    return this.oriVal(value);
                }
            }
            if (ele) {
                if (ele.data('masked') && !isEmptyString(ele.data('masked-value'))) {
                    return String(ele.data('masked-value'));
                } else {
                    return ele.oriVal();
                }
            }
            return undefined;
        };
    }
    
}

//for group_id file
function generateUUID(prefix) {
    var d = new Date().getTime();
    var uuid = prefix + '-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
    return uuid;
};

$.fn.setMasked = function (d) {
    if (d == null) d = 2;
    $(this).css('text-align', 'right').data({ 'masked': true, 'masked-decimal': d }).focusin(function () {
        if (typeof $(this).val() == 'object') {
            $(this).oriVal(0);
        } else {
            $(this).oriVal($(this).val());
        }
        $(this).data('masked-focused', true);
    }).change(function () {
        if($(this).data('masked-focused')) $(this).val($.trim($(this).oriVal()));
        $(this).data('masked-focused', false);
    }).focusout(function () {
        if($(this).data('masked-focused')) $(this).val($(this).oriVal());
        $(this).data('masked-focused', false);
    }).rules('add', { number2: true });
    $.validator.messages.number2 = 'Please enter a valid number';
    if ($.fn.oriVal == null) {
        $.fn.oriVal = $.fn.val;
        $.fn.val = function (value) {
            if (this[0]) var ele = $(this[0]);
            // setter
            if (typeof value != 'undefined') {
                if (ele && ele.data('masked')) {
                    if (!isEmptyString(value)) {
                        ele.data('masked-value', String(value).split(',').join(''));
                        return this.oriVal($.number(value, ele.data('masked-decimal')));
                    } else {
                        ele.data('masked-value', '');
                        return this.oriVal('');
                    }
                } else {
                    return this.oriVal(value);
                }
            }
            // getter
            if (ele) {
                if (ele.data('masked') && !isEmptyString(ele.data('masked-value'))) {
                    return String(ele.data('masked-value'));
                } else {
                    return ele.oriVal();
                }
            }
            return undefined;
        };
    }
    return $(this);
}

function convertNETDateTime(sNetDate) {
    if (sNetDate == null) return null;
    if (sNetDate instanceof Date) return sNetDate;
    var r = /\/Date\(([0-9]+)\)\//i
    var matches = sNetDate.match(r);
    if (matches.length == 2) {
        return new Date(parseInt(matches[1]));
    }
    else {
        return sNetDate;
    }
}