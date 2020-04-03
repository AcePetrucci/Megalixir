/** 
 * Main SCSS
 */

import './Collapse.component.scss';


/**
 * Custom Scripts
 */

const toggleDataPrivacyCollapse = () => {
  document.querySelectorAll('[data-collapse]').forEach(collapse => {
    collapse.addEventListener('click', $event => {
      const target = $event.target as HTMLDivElement;
      target.parentElement.classList.toggle('-opened');
    })
  });
}

toggleDataPrivacyCollapse();