import { formatNumber } from '@angular/common';
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'formatHeight'
})
export class FormatHeightPipe implements PipeTransform {

  transform(metres: number): string {
    const feet = metres * 3.28084;
    return (
      formatNumber(metres, 'en-GB', '1.0-0') + 'm (' +
      formatNumber(feet, 'en-GB', '1.0-0') + 'ft)'
    );
  }

}
