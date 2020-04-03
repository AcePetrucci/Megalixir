/** 
 * Main SCSS
 */

import './Collapse-Composition.component.scss';


/**
 * Sub Components
 */

import './sub-components/Collapse-Composition-Title/Collapse-Composition-Title.component';
import './sub-components/Collapse-Composition-Description/Collapse-Composition-Description.component';


/**
 * Custom Scripts
 */

const toggleDataPrivacyCollapseComposition = () => {
  document.querySelectorAll('[data-collapse-composition]').forEach(collapse => {
    collapse.addEventListener('click', $event => {
      const target = $event.target as HTMLDivElement;
      target.parentElement.classList.toggle('-opened');
      $event.preventDefault();
    })
  });
}

toggleDataPrivacyCollapseComposition();