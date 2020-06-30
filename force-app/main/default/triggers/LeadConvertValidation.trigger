trigger LeadConvertValidation on Lead (before update) {

    for(Lead l:Trigger.new){
        if(l.LastName.containsIgnoreCase('DoNotConvert')){
            l.addError('Lead is not eligible for conversion');
        }
    }
}