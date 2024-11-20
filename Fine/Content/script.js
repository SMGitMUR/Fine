/*active button class onclick*/
$('nav a').click(function(e) {
  e.preventDefault();
  $('nav a').removeClass('active');
    $(this).addClass('active');
    
    if (this.id === !'lnkcus'){
    $('.payment').addClass('noshow');
  }
    else if (this.id === 'lnkcus') {
    $('.payment').removeClass('noshow');
    $('.rightbox').children().not('.payment').addClass('noshow');
  }
    else if (this.id === 'lnkrep') {
    $('.profile').removeClass('noshow');
     $('.rightbox').children().not('.profile').addClass('noshow');
  }
    else if (this.id === 'lnkpro') {
    $('.subscription').removeClass('noshow');
    $('.rightbox').children().not('.subscription').addClass('noshow');
  }
    else if (this.id === 'lnksum') {
    $('.privacy').removeClass('noshow');
    $('.rightbox').children().not('.privacy').addClass('noshow');
  }
  else if(this.id === 'settings') {
    $('.settings').removeClass('noshow');
    $('.rightbox').children().not('.settings').addClass('noshow');
  }
});