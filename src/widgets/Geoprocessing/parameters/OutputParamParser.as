///////////////////////////////////////////////////////////////////////////
// Copyright (c) 2011 Esri. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
///////////////////////////////////////////////////////////////////////////
package widgets.Geoprocessing.parameters
{

import com.esri.viewer.utils.PopUpInfoParser;

public class OutputParamParser extends BaseParamParser
{
    override public function parseParameters(paramsXML:XMLList):Array
    {
        var params:Array = [];
        var param:IGPParameter;

        for each (var paramXML:XML in paramsXML)
        {
            param = GPParameterFactory.getGPParamFromType(paramXML.@type);
            param.label = paramXML.@label;
            param.name = paramXML.@name;
            param.toolTip = paramXML.@tooltip;

            var featureParam:IGPFeatureParameter = param as IGPFeatureParameter;
            if (featureParam)
            {
                featureParam.geometryType = paramXML.@geometrytype;
                featureParam.layerName = featureParam.label;

                if (paramXML.popup[0])
                {
                    featureParam.popUpInfo = PopUpInfoParser.parsePopUpInfo(paramXML.popup[0]);
                }

                featureParam.renderer = featureParam.geometryType ? parseRenderer(paramXML.renderer[0], featureParam.geometryType) : null;
            }

            params.push(param);
        }

        return params;
    }
}
}
