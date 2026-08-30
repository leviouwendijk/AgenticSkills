import Agentic
import AgenticIO

public extension CoreSkillProvider {
    static let debuggingLoop = AgentSkill(
        identifier: "debugging-loop",
        name: "Debugging loop",
        summary: "Turn failures into a small hypothesis, inspect evidence, patch minimally, and re-check.",
        body: """
        Use a tight debugging loop.

        Workflow:
        1. Restate the observed failure in concrete terms.
        2. Separate symptoms from likely causes.
        3. Identify the smallest code, data, or configuration region that could explain the failure.
        4. Inspect that region before proposing a fix.
        5. Form one primary hypothesis and, if useful, one fallback hypothesis.
        6. Make the smallest change that addresses the primary hypothesis.
        7. After the change, explain what would need to be run or inspected to verify it.

        When tools are available:
        - Use `\(FindPathsTool.identifier.rawValue)` when the failing file is unknown but path names or concepts can narrow it.
        - Use `\(SearchSourcesTool.identifier.rawValue)` with failing identifiers, symbols, messages, or hypotheses to locate likely source regions.
        - Use `\(LoadSearchContextTool.identifier.rawValue)` to inspect the strongest search candidates before patching.
        - Use `\(ReadFileTool.identifier.rawValue)` when an exact source region is already known or a direct fallback read is appropriate.
        - Use `\(ScanPathsTool.identifier.rawValue)` when filesystem topology itself must be inspected.
        - Use `\(EditFileTool.identifier.rawValue)` for small patches.
        - Use `\(WriteFileTool.identifier.rawValue)` only when a whole-file replacement is justified.

        Debugging discipline:
        - Do not rewrite working code to fit a preferred style.
        - Do not fix unrelated issues discovered along the way.
        - Do not claim verification happened unless a tool or user-provided output supports it.
        - If no runner or test tool exists, state the verification gap explicitly.
        """,
        metadata: .init(
            domains: [
                .core
            ],
            tools: .init(
                optional: [
                    .tool(FindPathsTool.identifier),
                    .tool(SearchSourcesTool.identifier),
                    .tool(LoadSearchContextTool.identifier),
                    .tool(ReadFileTool.identifier),
                    .tool(ScanPathsTool.identifier),
                    .tool(EditFileTool.identifier),
                    .tool(WriteFileTool.identifier)
                ]
            ),
            tags: [
                "core",
                "debugging",
                "workflow"
            ],
            attributes: [
                "pack": "base",
                "kind": "workflow"
            ]
        )
    )
}
