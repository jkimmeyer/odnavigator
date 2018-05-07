module OdmLicenses
  def get_open_licenses
    open_licenses = [
      'CC0',
      'ODC-PDDL','Open Data Commons Public Domain Dedication and Licence','PDDL',
      'CC BY', 'CC-BY', 'cc-zero',
      'ODC-BY',
      'CC BY-SA', 'CC-BY-SA',
      'ODC-ODbL','ODbL',
      'Free Art License','FAL',
      'GFDL','GNU FDL',
      'GNU GPL-2.0','GNU GPL-3.0',
      'OGL','OGL-UK-2.0','OGL-UK-3.0','SOGL',
      'Open Government Licence - Canada 2.0','Open Government Licence Canada 2.0',
      'OGL-Canada-2.0',
      'MirOS License',
      'Talis Community License',
      'Against DRM',
      'DL-DE-BY-2.0','Data licence Germany – attribution – version 2.0','Data licence Germany – Zero – version 2.0', 'Datenlizenz Deutschland – Namensnennung – Version 2.0','https://creativecommons.org/licenses/by/3.0/de/',
      'Design Science License','EFF Open Audio License',
      'SPL',
      'W3C license',
      'Licence-Ouverte', 'FR-LO'
    ]
    return open_licenses.map(&:downcase)
  end
end
