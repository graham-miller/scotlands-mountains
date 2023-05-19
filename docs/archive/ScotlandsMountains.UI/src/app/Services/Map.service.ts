import { Injectable } from "@angular/core";
import * as L from 'leaflet';
import GestureHandling from 'leaflet-gesture-handling';

L.Marker.prototype.options.icon = L.divIcon({ className: 'mountain-marker' });
L.Map.addInitHook("addHandler", "gestureHandling", GestureHandling);

@Injectable()
export class MapService {
    
    public createMap(element: string | HTMLElement, layerGroups: L.LayerGroup<any>[]): L.Map {

        const map = L.map(element, this.mapOptions);
        map.attributionControl.setPrefix('');
        L.control.scale(this.scaleOptions).addTo(map);

        const markers = L.layerGroup(layerGroups);

        L.control.layers(this.baseLayers, {'Markers': markers}).addTo(map);
        this.baseLayers['Outdoors'].addTo(map);
        markers.addTo(map);

        return map;
    }

    public destroyMap(map: L.Map, replaceWith: string) {
        map.off();
        map.remove();
        map.getContainer().replaceWith(replaceWith);
    }

    public readonly defaultCenter: L.LatLngExpression = [56.659406, -4.011214];
    public readonly defaultZoom = 7

    private mapOptions = {
        center: this.defaultCenter,
        zoom: this.defaultZoom,
        gestureHandling: true,
    } as L.MapOptions;

    private scaleOptions = {
        maxWidth: 200,
        metric: true,
        imperial: true,
        updateWhenIdle: false,
        position: 'bottomright'
    } as L.Control.ScaleOptions;

    private baseLayers = {
        'Outdoors': this.createThunderforestTileLayer('outdoors'),
        'Landscape': this.createThunderforestTileLayer('landscape'),
        'Transport': this.createThunderforestTileLayer('transport'),
        'Cycle': this.createThunderforestTileLayer('cycle')
    };

    private createThunderforestTileLayer(moniker: string): L.TileLayer {
        return L.tileLayer(
            `https://tile.thunderforest.com/${moniker}/{z}/{x}/{y}.png?apikey=231e70bf20b64d8ca94199922441d3f7`,
            { maxZoom: 18 });
    }
}